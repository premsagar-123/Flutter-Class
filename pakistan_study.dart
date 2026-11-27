import 'package:flutter/material.dart';

class PakistanStudyPage extends StatefulWidget {
  const PakistanStudyPage({super.key});

  @override
  State<PakistanStudyPage> createState() => _PakistanStudyPageState();
}

class _PakistanStudyPageState extends State<PakistanStudyPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> _results = [];
  bool _searched = false;

  static const Color darkGreen = Color.fromARGB(255, 11, 70, 52);
  static const Color green = Color.fromARGB(255, 13, 53, 36);

  final List<Map<String, String>> _database = [
    {
      'title': 'Introduction to Pakistan',
      'category': 'General Knowledge',
      'keys': 'pakistan|about pakistan|introduction|pakistan introduction|pakistan kya hai|mulk',
      'english': 'Pakistan is a country in South Asia. It became independent on 14 August 1947. Its capital is Islamabad. Its four provinces are Punjab, Sindh, Khyber Pakhtunkhwa and Balochistan. Urdu is its national language.',
      'sindhi': 'پاڪستان ڏکڻ ايشيا ۾ واقع هڪ ملڪ آهي. اهو 14 آگسٽ 1947ع تي آزاد ٿيو. پاڪستان جو گاديءَ جو هنڌ اسلام آباد آهي. ان جا چار صوبا پنجاب، سنڌ، خيبر پختونخوا ۽ بلوچستان آهن. اردو پاڪستان جي قومي ٻولي آهي.',
    },
    {
      'title': 'History of Pakistan: 1900–2026',
      'category': 'History',
      'keys': 'history|histry|tareekh|pakistan history|pakistan ki history|1900|2026',
      'english': 'Important events include: the All-India Muslim League was established in 1906; Allama Iqbal delivered his Allahabad Address in 1930; the Lahore Resolution was adopted in 1940; Pakistan became independent in 1947; the first Constitution came into effect in 1956; East Pakistan became Bangladesh in 1971; the 1973 Constitution came into effect in 1973; Pakistan conducted nuclear tests in 1998; and the 18th Constitutional Amendment was passed in 2010. Events in 2025 and 2026 should be checked against reliable, up-to-date sources.',
      'sindhi': 'پاڪستان جي تاريخ جا اهم واقعا هي آهن: 1906ع ۾ آل انڊيا مسلم ليگ قائم ٿي؛ 1930ع ۾ علامه اقبال الهه آباد جو خطبو ڏنو؛ 1940ع ۾ قراردادِ لاهور منظور ٿي؛ 1947ع ۾ پاڪستان آزاد ٿيو؛ 1956ع ۾ پهريون آئين نافذ ٿيو؛ 1971ع ۾ اوڀر پاڪستان الڳ ٿي بنگلاديش بڻيو؛ 1973ع ۾ پاڪستان جو آئين نافذ ٿيو؛ 1998ع ۾ پاڪستان ايٽمي تجربا ڪيا؛ ۽ 2010ع ۾ ارڙهين آئيني ترميم منظور ٿي. 2025ع ۽ 2026ع جي تازن واقعن لاءِ معتبر ۽ نون ذريعن مان تصديق ڪرڻ ضروري آهي.',
    },
    {
      'title': 'When Did Pakistan Become Independent?',
      'category': 'History',
      'keys': 'independence|independent|14 august|1947|pakistan kab bana|pakistan azaad|azadi|azaad hua',
      'english': 'Pakistan became independent on 14 August 1947. Muhammad Ali Jinnah, known as Quaid-e-Azam, was the founder of Pakistan and its first Governor-General. Liaquat Ali Khan was Pakistan’s first Prime Minister.',
      'sindhi': 'پاڪستان 14 آگسٽ 1947ع تي آزاد ٿيو. محمد علي جناح، جيڪو قائداعظم جي نالي سان مشهور آهي، پاڪستان جو باني ۽ پهريون گورنر جنرل هو. لياقت علي خان پاڪستان جو پهريون وزيراعظم هو.',
    },
    {
      'title': 'Lahore Resolution',
      'category': 'History',
      'keys': 'lahore resolution|qarardad e pakistan|23 march|1940|pakistan resolution',
      'english': 'The Lahore Resolution was adopted on 23 March 1940 at the Muslim League’s session in Lahore. It became a major milestone in the political struggle that led to the creation of Pakistan. Pakistan Day is observed on 23 March.',
      'sindhi': 'قراردادِ لاهور 23 مارچ 1940ع تي لاهور ۾ مسلم ليگ جي اجلاس ۾ منظور ٿي. اها سياسي جدوجهد جو هڪ اهم سنگ ميل هئي، جنهن پاڪستان جي قيام لاءِ رستو هموار ڪيو. پاڪستان جو ڏهاڙو 23 مارچ تي ملهايو ويندو آهي.',
    },
    {
      'title': 'Quaid-e-Azam Muhammad Ali Jinnah',
      'category': 'History',
      'keys': 'quaid e azam|quaid azam|jinnah|muhammad ali jinnah|founder|baba e qaum',
      'english': 'Quaid-e-Azam Muhammad Ali Jinnah was the founder of Pakistan. He was born in Karachi on 25 December 1876. He became Pakistan’s first Governor-General and died on 11 September 1948.',
      'sindhi': 'قائداعظم محمد علي جناح پاڪستان جو باني هو. هو 25 ڊسمبر 1876ع تي ڪراچيءَ ۾ پيدا ٿيو. هو پاڪستان جو پهريون گورنر جنرل بڻيو ۽ 11 سيپٽمبر 1948ع تي وفات ڪيائين.',
    },
    {
      'title': 'Allama Muhammad Iqbal',
      'category': 'History',
      'keys': 'allama iqbal|iqbal|poet|poet of east|shair e mashriq|allahabad address',
      'english': 'Allama Muhammad Iqbal was a famous poet, philosopher and political thinker. He was born in Sialkot on 9 November 1877. His Allahabad Address of 1930 is an important event in the history of the Pakistan Movement.',
      'sindhi': 'علامه محمد اقبال هڪ مشهور شاعر، فلسفي ۽ سياسي مفڪر هو. هو 9 نومبر 1877ع تي سيالڪوٽ ۾ پيدا ٿيو. سندس 1930ع وارو خطبو الهه آباد تحريڪِ پاڪستان جي تاريخ ۾ اهم حيثيت رکي ٿو.',
    },
    {
      'title': 'Provinces of Pakistan',
      'category': 'Geography',
      'keys': 'province|provinces|soobay|subay|sindh|punjab|balochistan|khyber pakhtunkhwa',
      'english': 'Pakistan has four provinces: Punjab, Sindh, Khyber Pakhtunkhwa and Balochistan. Islamabad is a federal capital territory. Gilgit-Baltistan and Azad Jammu and Kashmir have separate administrative arrangements.',
      'sindhi': 'پاڪستان جا چار صوبا آهن: پنجاب، سنڌ، خيبر پختونخوا ۽ بلوچستان. اسلام آباد وفاقي گاديءَ وارو علائقو آهي. گلگت بلتستان ۽ آزاد ڄمون ۽ ڪشمير جا الڳ انتظامي نظام آهن.',
    },
    {
      'title': 'Capital of Pakistan',
      'category': 'Geography',
      'keys': 'capital|capital city|dar ul hukumat|islamabad|pakistan capital',
      'english': 'Islamabad is the capital of Pakistan. Karachi is the largest city of Pakistan and the capital of Sindh province.',
      'sindhi': 'اسلام آباد پاڪستان جو گاديءَ جو هنڌ آهي. ڪراچي پاڪستان جو سڀ کان وڏو شهر ۽ سنڌ صوبي جي گاديءَ جو هنڌ آهي.',
    },
    {
      'title': 'Rivers of Pakistan',
      'category': 'Geography',
      'keys': 'river|rivers|darya|indus|sindhu|jhelum|chenab|ravi|sutlej',
      'english': 'Important rivers of Pakistan include the Indus, Jhelum, Chenab, Ravi and Sutlej. These rivers are important for agriculture, irrigation and water supplies.',
      'sindhi': 'پاڪستان جا اهم درياهه سنڌو، جهلم، چناب، راوي ۽ ستلج آهن. اهي درياهه زراعت، آبپاشي ۽ پاڻيءَ جي فراهميءَ لاءِ تمام اهم آهن.',
    },
    {
      'title': 'Mountains of Pakistan',
      'category': 'Geography',
      'keys': 'mountain|mountains|pahaar|highest peak|k2|nanga parbat',
      'english': 'K2 is the highest mountain in Pakistan, with an elevation of approximately 8,611 metres. It is the world’s second-highest mountain above sea level. Nanga Parbat is another famous mountain in Pakistan.',
      'sindhi': 'ڪي ٽو پاڪستان جو سڀ کان اوچو جبل آهي، جنهن جي اوچائي لڳ ڀڳ 8,611 ميٽر آهي. سمنڊ جي سطح کان اوچائيءَ جي لحاظ کان اهو دنيا جو ٻيو نمبر بلند ترين جبل آهي. نانگا پربت پاڪستان جو هڪ ٻيو مشهور جبل آهي.',
    },
    {
      'title': 'Neighbouring Countries of Pakistan',
      'category': 'Geography',
      'keys': 'neighbour|neighbor|neighbours|neighbors|hamsaya|border|sarhad|countries',
      'english': 'Pakistan shares land borders with India, Afghanistan, Iran and China. The Arabian Sea lies to the south of Pakistan.',
      'sindhi': 'پاڪستان جون زميني سرحدون ڀارت، افغانستان، ايران ۽ چين سان ملن ٿيون. پاڪستان جي ڏکڻ ۾ عربي سمنڊ آهي.',
    },
    {
      'title': 'National Anthem of Pakistan',
      'category': 'General Knowledge',
      'keys': 'national anthem|qaumi tarana|anthem|hafeez jalandhari|ahmed g chagla',
      'english': 'The lyrics of Pakistan’s national anthem were written by Hafeez Jalandhari, and its music was composed by Ahmed G. Chagla. The anthem was officially adopted in 1954.',
      'sindhi': 'پاڪستان جي قومي تراني جا ٻول حفيظ جالندھري لکيا ۽ ان جي ڌُن احمد جي. چاڳلا ٺاهي. قومي ترانو 1954ع ۾ سرڪاري طور منظور ڪيو ويو.',
    },
    {
      'title': 'National Symbols of Pakistan',
      'category': 'General Knowledge',
      'keys': 'national symbols|national animal|markhor|national flower|jasmine|chambeli|qaumi janwar|qaumi phool',
      'english': 'Pakistan’s national animal is the markhor, its national flower is jasmine, and its national bird is the chukar partridge.',
      'sindhi':
          'پاڪستان جو قومي جانور مارخور، قومي گل چنبيلي ۽ قومي پکي چڪور آهي.',
    },
    {
      'title': 'National Language of Pakistan',
      'category': 'General Knowledge',
      'keys': 'national language|qaumi zaban|urdu|languages|zabanen',
      'english': 'Urdu is Pakistan’s national language. Punjabi, Sindhi, Pashto, Balochi, Saraiki, Brahui and other languages are also spoken in the country. English is used in many official and administrative settings.',
      'sindhi': 'اردو پاڪستان جي قومي ٻولي آهي. ملڪ ۾ پنجابي، سنڌي، پشتو، بلوچي، سرائيڪي، براھوي ۽ ٻيون ٻوليون پڻ ڳالهايون وڃن ٿيون. انگريزي ڪيترن ئي سرڪاري ۽ انتظامي ڪمن ۾ استعمال ٿئي ٿي.',
    },
    {
      'title': 'Currency of Pakistan',
      'category': 'General Knowledge',
      'keys': 'currency|money|rupee|paisa|pakistani rupee|pkr',
      'english': 'The official currency of Pakistan is the Pakistani Rupee. Its international currency code is PKR.',
      'sindhi': 'پاڪستان جي سرڪاري ڪرنسي پاڪستاني رپيو آهي. ان جو بين الاقوامي ڪرنسي ڪوڊ PKR آهي.',
    },
    {
      'title': 'Constitution of Pakistan',
      'category': 'Civics',
      'keys': 'constitution|aaeen|1973 constitution|18th amendment',
      'english': 'Pakistan’s current basic Constitution was adopted in 1973. The 18th Constitutional Amendment was passed in 2010 and made important changes to the distribution of powers between the federation and the provinces.',
      'sindhi': 'پاڪستان جو موجوده بنيادي آئين 1973ع ۾ منظور ٿيو. ارڙهين آئيني ترميم 2010ع ۾ منظور ڪئي وئي، جنهن وفاق ۽ صوبن جي اختيارن جي ورڇ ۾ اهم تبديليون آنديون.',
    },
    {
      'title': 'Largest City of Pakistan',
      'category': 'Geography',
      'keys': 'largest city|biggest city|bara shehar|karachi|population city',
      'english': 'Karachi is Pakistan’s largest city. It is the capital of Sindh, a major commercial centre and home to an important seaport.',
      'sindhi': 'ڪراچي پاڪستان جو سڀ کان وڏو شهر آهي. اهو سنڌ جي گاديءَ جو هنڌ، هڪ اهم واپاري مرڪز ۽ وڏي بندرگاهه وارو شهر آهي.',
    },
    {
      'title': 'Deserts of Pakistan',
      'category': 'Geography',
      'keys': 'desert|deserts|registan|thar|cholistan|thall|kharan',
      'english': 'Famous deserts of Pakistan include the Thar, Cholistan, Thal and Kharan deserts. The Thar Desert extends across parts of Sindh in southeastern Pakistan.',
      'sindhi': 'پاڪستان جا مشهور ريگستان ٿر، چولستان، ٿل ۽ خاران آهن. ٿر جو ريگستان ڏکڻ اوڀر پاڪستان ۾ سنڌ جي مختلف علائقن تائين پکڙيل آهي.',
    },
    {
      'title': 'Lakes of Pakistan',
      'category': 'Geography',
      'keys': 'lake|lakes|jheel|manchar|saif ul malook|attabad',
      'english': 'Famous lakes in Pakistan include Manchar Lake, Keenjhar Lake, Saif-ul-Malook Lake and Attabad Lake. Manchar Lake is located in Sindh.',
      'sindhi': 'پاڪستان جون مشهور ڍنڍون منڇر ڍنڍ، ڪينجهر ڍنڍ، سيف الملوڪ ڍنڍ ۽ عطاآباد ڍنڍ آهن. منڇر ڍنڍ سنڌ ۾ واقع آهي.',
    },
    {
      'title': 'Economy of Pakistan',
      'category': 'Economy',
      'keys': 'economy|maeeshat|agriculture|zaraat|exports|industry',
      'english': 'Pakistan’s economy includes services, agriculture and industry. Important agricultural products include wheat, rice and cotton. Economic statistics change over time, so the latest figures should be checked using reliable official sources.',
      'sindhi': 'پاڪستان جي معيشت ۾ خدمتن جو شعبو، زراعت ۽ صنعت اهم ڪردار ادا ڪن ٿا. ڪڻڪ، چانور ۽ ڪپهه اهم زرعي پيداوار آهن. معاشي انگ اکر وقت سان تبديل ٿيندا رهن ٿا، تنهنڪري تازن انگن اکرن لاءِ معتبر سرڪاري ذريعن کي ڏسڻ گهرجي.',
    },
    {
      'title': 'National Sport of Pakistan',
      'category': 'Sports',
      'keys': 'national sport|qaumi khel|hockey|sports',
      'english': 'Field hockey is commonly described as Pakistan’s national sport. Cricket is also extremely popular throughout the country.',
      'sindhi': 'فيلڊ هاڪي کي عام طور پاڪستان جي قومي راند چيو ويندو آهي. ڪرڪيٽ پڻ سڄي ملڪ ۾ تمام گهڻي مشهور آهي.',
    },
    {
      'title': 'National Parks of Pakistan',
      'category': 'Geography',
      'keys': 'national parks|hingol|deosai|khunjerab|wildlife',
      'english': 'Famous national parks in Pakistan include Hingol National Park, Deosai National Park and Khunjerab National Park. These parks help protect wildlife and natural habitats.',
      'sindhi': 'پاڪستان جا مشهور قومي پارڪ هنگول نيشنل پارڪ، ديوا سائي نيشنل پارڪ ۽ خنجراب نيشنل پارڪ آهن. اهي پارڪ جهنگلي جيوت ۽ قدرتي ماحول جي حفاظت ۾ مدد ڪن ٿا.',
    },
    {
      'title': 'Prime Ministers of Pakistan',
      'category': 'History',
      'keys': 'prime minister|prime ministers|pm|wazir e azam|liaquat ali khan|shehbaz sharif',
      'english': 'Liaquat Ali Khan was Pakistan’s first Prime Minister. Pakistan has had many Prime Ministers over the years. Check an official government source for current officeholders because this information can change.',
      'sindhi': 'لياقت علي خان پاڪستان جو پهريون وزيراعظم هو. پاڪستان ۾ مختلف سالن دوران ڪيترائي وزيراعظم رهيا آهن. موجوده وزيراعظم بابت ڄاڻ لاءِ سرڪاري ذريعن کي ڏسڻ گهرجي، ڇاڪاڻ ته اها معلومات تبديل ٿي سگهي ٿي.',
    },
    {
      'title': 'What Can I Ask?',
      'category': 'Study Help',
      'keys': 'help|topics|what can i ask|questions|study help',
      'english': 'You can ask about Pakistan’s history, independence, Quaid-e-Azam, Allama Iqbal, provinces, capital, rivers, mountains, national symbols, Constitution and geography. This version answers only questions covered by its built-in database.',
      'sindhi': 'توهان پاڪستان جي تاريخ، آزادي، قائداعظم، علامه اقبال، صوبن، گاديءَ جي هنڌ، درياهن، جبلن، قومي نشانين، آئين ۽ جاگرافي بابت سوال پڇي سگهو ٿا. هن ورزن ۾ صرف اڳ ۾ شامل ڪيل معلومات جا جواب موجود آهن.',
    },
  ];

  final List<Map<String, String>> _topics = [
    {'label': '📚 History', 'query': 'Pakistan history'},
    {'label': '🌍 Geography', 'query': 'Pakistan geography'},
    {'label': '🗺️ Provinces', 'query': 'Pakistan provinces'},
    {'label': '🏞️ Rivers', 'query': 'Pakistan rivers'},
    {'label': '🇵🇰 National Symbols', 'query': 'Pakistan national symbols'},
    {'label': '🎉 Independence', 'query': 'Pakistan independence'},
    {'label': '👤 Quaid-e-Azam', 'query': 'Quaid e Azam'},
    {'label': '🏛️ Capital', 'query': 'Pakistan capital'},
  ];

  String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r"[’']"), '')
        .replaceAll(RegExp(r'[^a-z0-9\u0600-\u06FF\s]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  void _search(String rawQuery) {
    final query = _normalize(rawQuery);
    if (query.isEmpty) return;

    final words = query.split(' ').where((word) => word.length > 1).toList();
    final scored = <Map<String, dynamic>>[];

    for (final item in _database) {
      var score = 0;

      final title = _normalize(item['title'] ?? '');
      final keys = (item['keys'] ?? '').split('|').map(_normalize).toList();

      if (title == query) score += 20;
      if (keys.contains(query)) score += 18;

      for (final key in keys) {
        if (key.length > 2 && query.contains(key)) score += 10;
        if (key.length > 2 && key.contains(query)) score += 5;
      }

      for (final word in words) {
        if (title.contains(word)) score += 4;

        for (final key in keys) {
          if (key.split(' ').contains(word)) score += 3;
        }
      }

      if (score > 0) {
        scored.add({'item': item, 'score': score});
      }
    }

    scored.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));

    setState(() {
      _searched = true;
      _results = scored
          .take(3)
          .map((entry) => entry['item'] as Map<String, String>)
          .toList();
    });

    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _topicButton(Map<String, String> topic) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        _searchController.text = topic['query']!;
        _search(topic['query']!);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          topic['label']!,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }

  Widget _answerCard(Map<String, String> item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2E9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              item['category']!,
              style: const TextStyle(
                color: Color(0xFF065F46),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item['title']!,
            style: const TextStyle(
              color: Color(0xFF087F5B),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '🇬🇧 Answer in English',
            style: TextStyle(
              color: Color(0xFF087F5B),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            item['english']!,
            style: const TextStyle(
              color: Color(0xFF263238),
              height: 1.7,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            '🇵🇰 جواب سنڌيءَ ۾',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color: Color(0xFF087F5B),
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(7),
              border: const Border(
                right: BorderSide(color: Color(0xFF087F5B), width: 4),
              ),
            ),
            child: Text(
              item['sindhi']!,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Color(0xFF263238),
                height: 2,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      appBar: AppBar(
        title: const Text(
          'Pakistan Study',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/image/back_grounds.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: const Color(0xFFE7F4EC));
              },
            ),
          ),

          // White overlay removed
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [darkGreen, green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text('🇵🇰', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 8),
                    const Text(
                      'Pakistan Study Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 234, 238, 11),
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Explore Pakistan’s History, Geography, Culture and General Knowledge.\n'
                      'Ask your question and get the answer in English and Sindhi.\n'
                      'پنھنجو سوال پڇو ۽ انگريزي توڙي سنڌيءَ ۾ جواب حاصل ڪريو.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFE0F2E9),
                        height: 1.7,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              textInputAction: TextInputAction.search,
                              onSubmitted: _search,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 252, 247, 247),
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Ask about Pakistan...',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 248, 240, 240),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _search(_searchController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            child: const Text('🔍 Search'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 9,
                runSpacing: 9,
                children: _topics.map(_topicButton).toList(),
              ),
              if (_searched) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🇵🇰 Pakistan Study Results',
                        style: TextStyle(
                          color: green,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_results.isEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Sorry, this question is not available in the database yet.',
                          style: TextStyle(color: Color(0xFF263238)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'معاف ڪجو، هن سوال جو جواب اڃا اسان جي معلومات ۾ موجود ناهي.',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 17,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'This version uses a limited database. An AI backend is needed to answer new questions automatically.',
                          style: TextStyle(color: Color(0xFF555555)),
                        ),
                      ],
                      ..._results.map(_answerCard),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 22),
              const Text(
                'Pakistan Study • Learn • Explore • Improve Your Knowledge',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF36745B), fontSize: 12),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
