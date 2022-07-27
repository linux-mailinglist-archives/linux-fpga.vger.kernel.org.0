Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AA58314B
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jul 2022 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbiG0Rx1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jul 2022 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbiG0RxD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 27 Jul 2022 13:53:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734A664E5;
        Wed, 27 Jul 2022 09:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658941065; x=1690477065;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KUrk7PR+QiscyP/js/aPiisfg00dl7ph+l+UFXn65bc=;
  b=Kk9rP9jQpYSOBwuuNrkJqcLisbpvKq5+m5TjQeHSB0JfK/3OeFRnaO98
   qzDbMLszAFkrcKmBSe3y9maN7oLqrxz0pjzNhCyJ7C1QKVL0zklXAVQwT
   1ynT6Ub8er1qha0aVBAEe2ZksnpWYNJAfyB7nHlHTHcgn7EAfil4hFXBx
   PpKqFjcieA6MRIskawlMOlKgSoQ5iGhtUF/85Orl1Rt1nTs9mj+EuJGho
   NU58YxncxK/B0JYBtbDrcB2RCGI3aJLzNEqlBrbHzbsxk3EkvlmB41Ayb
   PnM84DfjeC0AnrW/oV0cRzXcLozhMaIfL1uyc0YWcrAydrikHvczb+GWo
   A==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="106400444"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 09:57:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 09:57:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 27 Jul 2022 09:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0Svsa8HpktYQ+2Gcst5yuOM5lyo44NZ2NuEAUNvvFRzAquLkdPrR9CHQJM2HytUYZvAvDl6whs1gU+hKsV/TiJB6SZT5qm1Rp1THNSqXv+1ehHaM2eWMV3mGYcUi98ixzAXj9Nq+5/CrApaQ43eJ2zAW3BrgiIoCh0pgzvFe9HhZDgSRIFG2tfMWt7YE1LSpjkdc9lny1qCKJlZmyGz0dPxAbvn6HJ1H9TSj0Gq8mobkHlubxLYiv5hP/m1AVoXhBSVhY5tbUy8Fw/TY2wHHrN2JAKnYjnIyAL1sv9PesuhFyjAvHQW9uMpysfWVz58gLgkawhURhw9J3n4VlBt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUrk7PR+QiscyP/js/aPiisfg00dl7ph+l+UFXn65bc=;
 b=cbkVoRzDgeMhq7mcnbYaqQtm2JKVdyxouNjyPt9SC2h3vPo//i5ZAdArWY7DBI7kM54LY2JLYL1KjyJPAggEckbJp6qgt/SlWRj5Km4F2q+KQkb7tuVUt7ag629nQoSHTz6nWQs2V1UKE5UMRwrf45C1xGnjBUUFge/wmSORJ43fMSffqCZHwvGzbCiGlN9MF6OkUrFAcD/+QIHH20/OxSNKqodh2sh5dviZIjOiMVfGjgbCohRKRo5F1ZY7PlTkf+hZWQ2/NKaYxlKnQuJ5mJxjusO0/OeSuPszYj9nxXGSAtVjNPB+IBdiYdhvBpojMBjQsf47N3nyjEJWLupuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUrk7PR+QiscyP/js/aPiisfg00dl7ph+l+UFXn65bc=;
 b=tUw140vRQZ+R+tZANXn4ocm6SPymbJYJUg9bQ/JIZ10271R2I/EwaW0a/KMObtUrtPqRyInH1sSr70OIE6DLZ5G2IUtiB672T2XGwt9M3QrxZkQxd4Ji61ALnw+qTSUIs19Psd20xBt7fiw1r0DYFT8irlD/pJdzikZg8b845VA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 16:57:39 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 16:57:39 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <i.bornyakov@metrotek.ru>,
        <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Thread-Topic: [PATCH] dt-bindings: fpga: microchip,mpf-spi-fpga-mgr: use
 spi-peripheral-props.yaml
Thread-Index: AQHYodgiuClAJQHLFkm5YQbKggoK+K2ScESA
Date:   Wed, 27 Jul 2022 16:57:39 +0000
Message-ID: <80eeee3d-ff1c-393f-f894-5f0f32cd4112@microchip.com>
References: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164347.386398-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a94aafff-4585-4193-5997-08da6ff11d37
x-ms-traffictypediagnostic: SA0PR11MB4623:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yqW2Rfj5uXhd8zoLuU+TfiCgWFOc+Km/mpiN+TuvTumSFBvr9OriSJGcqbzz5kJPmaJXUul8CjI8Rh46uT8hwhpPYAOI4wZN3eFdv1jbaNHywLXMn5WDNh5xGxEH1tB5RchBjmSiIYXoK7kdFfAHngXVvakG0ANdsZtKZ/UB3cpZK1jGEf/DzcVL/l+wDx0EY8UQ973v3nisHHHrYuAuuQRBTX2NTnT1OAbCv6RGfdeERnVDdGlmVzltONerG0zPgu68H44Yzk8k+4jjaaVCs7lzh5hl/UgWTxaJZP1HW9DqoiyvfNnX9n91bA4szdwcRzaXE91iCdY9hsMwiIUuslld3AiYaEYNA62IKty+jkUi/qD4S5s1Y8zVDzQ8xvGVanR7q2t4rvJkBKLVKKKPrGMGCATFV6auVrL8SdrUL8aPlgAp4zCUInVTbK0NCL3U6GHDkJ1RGoWMvA+OT2cH1aOyNN9RuuX2+VIFKNwUyaoAxJTvLQkV5KEWPYWNxaTyBPd8hne4ICvIvKNSLhEJ7h8aCXS06Zz+LACh9sbHmS+F2OSMYlHQMAM9XxELn+WR9fB2Ma+ig1jkXrbEIwqe0UD/RX0WxRWHBfzYDlmImONTBMyyR5YyP08GPC3+SqdxQc17kmI32s+hVt0ByxHwGIK6EXfsYY5SjYVZm6esCeCGj5wYxRWWxLT5PndMMDA6tTVrcQ34sbeKzknnLMpKzJs1b6cTNKlUYz6LmEf6/EB3+mKhVI+lKbW54nJstejfRFlDvffng6C1X3w5+KfmKJz8XJ8CshSVTqaLrNAUnEhns8Anc4274iiKRNe85vU2rkYOzr0xFOAALZEzA4BMpnAq4BgB/h/3JaGXu37Q3oVZhQiJXXoCOsJ6whuxg8338T+Hs0xgRM0/yAFVK/sb42jQfi7zEhpbR6Uo4oZE5M8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(366004)(136003)(376002)(110136005)(316002)(2616005)(36756003)(6506007)(478600001)(41300700001)(966005)(53546011)(6486002)(26005)(6512007)(2906002)(71200400001)(31696002)(86362001)(64756008)(8676002)(76116006)(66476007)(91956017)(66556008)(66946007)(66446008)(5660300002)(8936002)(83380400001)(122000001)(38100700002)(921005)(186003)(38070700005)(31686004)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmlOUThERUw3TVE3MzRvVVd4WWlBdVdZZWhPbGtYbEJTWFd5Q3g5QWl0YjlL?=
 =?utf-8?B?U3M3T0tqdm1oRWVyTTNEUUtnakczTmgxaVZkcDdmYy90R3drb0QyQnlWSnN6?=
 =?utf-8?B?YmY4OUhJcytIVExXbGM4L1ZkRlpGeVdwZENicGwrYTBtVllwYy9aOXoxeXNP?=
 =?utf-8?B?Q3lndHFoTEY4TmRkNmJCTDYwcmI1NXJ0bWh5RUhNZ0gwRk1iazZFRUdpRWcw?=
 =?utf-8?B?dTE5WVd5TGU1eXF0L0I0V2hadVhsalp4UE84NHlVTFhVbzRLSnE5UUl2dzlX?=
 =?utf-8?B?QVYvam14eE9acWpvY2FrVzhLN2tQWUZ4SXBITi80M0xBck9BMEwyQkczb2ZG?=
 =?utf-8?B?RmYwVCtVZVJIQ09uejRhZFdncVdHb21FT0loQXZSazdmOTRTVTVSV0tJenpT?=
 =?utf-8?B?ZVQrdiszZjQ5a0JmZXl3QnRUQUNRYkpadW1QLzBYL3pPU3JNN1VGTEZRVkg5?=
 =?utf-8?B?M0pvSUZLTHlXUEJNN015SmM1M3dFa2lrWHB3bWdodUs5cFd4VVd4Nmt1cFR4?=
 =?utf-8?B?dGMveXlMRTI3YThRQXhibUVFUEprVDU3anFXVGtuZGNoUm95aE9HT0ZuaVMx?=
 =?utf-8?B?NzRPVzgraHdHY21PS3FpaUlNaUdWajlHWm04REw0SG5uazZpNVNKYUM1TmdT?=
 =?utf-8?B?MUk5am1oQTQ5Uk9OMVZqTDZIcEgyRUw2TEtrVnZEdzFUcDVTSllMY3BXUkcv?=
 =?utf-8?B?R1VkTmhuSkFUd0U2WXVjQkJ3bTBoMnVQQ3MvQklQSXROWkRGTjd1eFd6K0Zh?=
 =?utf-8?B?MmhLaytkWFNCenB4YTlKVzVQYkNVRkRtaExWUEJyMHFyTCtzYWlEdzdEV3dV?=
 =?utf-8?B?enAwT3hjLzhyWG9TQWdsQU82cW9MQldsSkdETlVzd1hTYktuV0c0NldEditZ?=
 =?utf-8?B?Um9QN0xOM2pVK2ZWeUdpRktQMUllRkZuYXEwVmR1UlFWWit1V21WN0ZQeVlz?=
 =?utf-8?B?dHpXVkhQQTRhSmViWXBwTjM1VjJUdjZuaEZyS2gzVy9iR21yNUtaV3Rodjgr?=
 =?utf-8?B?MWhLWHZTM0JMRXNWZ1VOWmdtMEpuVVcrbE1nS2N3YW5XcDl0Q1dGZmFiUTFw?=
 =?utf-8?B?aVIvZkozeFA3cU90L0oyYi9XeS92aFVMSU03T1RVY0s3QWtpQ05BclIvcmo5?=
 =?utf-8?B?STIwV2xobUlUUHZtZGk4MnRLQy9vOUZJSmVXc05uRnhhbDFQMG5rcTQ3dnVS?=
 =?utf-8?B?UDN5L1JFbE1vZ1FYMTVjYWlvSXpYK1RsT1ZpcTdyUDVweWVmU2lWZGxwd3BF?=
 =?utf-8?B?WStNZ2FXOEpsVGExNXpLZ01SM2o5QS9SQ3NwbkJ3ditxOGp1eDhWZTg2NGFK?=
 =?utf-8?B?Q1pKZ2psY0dCTllRZlFucFAzc2NtV3M1WFJsQzZ4T1d0akpOa1pRdXFJMm9k?=
 =?utf-8?B?dTJiWjUrS1lWSFZXbEk4NkpRMmhzRVdLVVlUZ2wzcjdFTkh1WW1RWEh5TTRK?=
 =?utf-8?B?MmJQNHRIQmc2NTl5M3Fsam12aGZ4OEEyVzl6NGhvZEtCVFdLT3BTQU85WDFu?=
 =?utf-8?B?ZlNtY3F2dUdwWWVSRUtYTVNxa2ZQaFBJTGUxbUtnQnRzK2tKR0xUbW9jMCta?=
 =?utf-8?B?MGp3cVg0ZWNuQnlxdmpsVUtnSXZ5RldpRlhWdXhVR2VYaVZnY0VJSDhNcTha?=
 =?utf-8?B?SlJIVlFLeWh1MER2Y24vb2tzQ3gyaG9jNnFVamQ1WUk2L1oweTZRQU9oSG96?=
 =?utf-8?B?NE1ZSld5VllMeWRPbXY5SEhVSTNvMFhqYVE2R2FPTWlkekFIbjA4RmdrbTYw?=
 =?utf-8?B?cy81UDI2cE1FZ2VxbzRQdEZyN3haT0ZoSndYOWdyWVdxcTBIaEszODU4azQ5?=
 =?utf-8?B?U0RoaTdwZEJlM1JQcWFYWTNzR21GWjJYVTVDTk83Mk5PUjFlZXpmQmhnanRO?=
 =?utf-8?B?TDR1MGJwQzJ6TnhpeEVrL3YxUnJpVEFHREdsWTZqRE0xdzNtbXlwZkd4K2Uy?=
 =?utf-8?B?ZFh2NEMyQnNoTkQvTHkxUE9HSkVoTXZvSVVQVy9TM3RsbmVDaEU2b0hXOEpw?=
 =?utf-8?B?RzZnSzFKYWpWQVB4MzZVbWcrS2tKNmtEU1JhOS9sNEFCYnorZHd5NlNiU1Jw?=
 =?utf-8?B?Y0JNUTJPRHVCb0ZDb2FrSXd4eDVOS2JtMUt1M2tuMldRR2xXUUlKWmp3ZTlE?=
 =?utf-8?B?QjJreTFYM2owVk50Q29EWjJtcGRwMzhRTVV5QTkwUW1OSXFrK0xRMHFJOGdP?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D82CDE2CFDBC46964A25D102955B8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94aafff-4585-4193-5997-08da6ff11d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 16:57:39.3845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zncxTGFzlGCdrWOWDkS7/fGeMOzJ0Ez54+y/gNE9TjCxrufJEfMXrYaQgY8tvQoYwUGPH3sNLN8ncy3NcgJwm9zIou+rZdBaJRgsn2VIk04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

SGV5IEtyenlzenRvZiwNCg0KT24gMjcvMDcvMjAyMiAxNzo0MywgS3J6eXN6dG9mIEtvemxvd3Nr
aSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbnN0
ZWFkIG9mIGxpc3RpbmcgZGlyZWN0bHkgcHJvcGVydGllcyB0eXBpY2FsIGZvciBTUEkgcGVyaXBo
ZXJhbHMsDQo+IHJlZmVyZW5jZSB0aGUgc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCBzY2hlbWEu
ICBUaGlzIGFsbG93cyB1c2luZyBhbGwNCj4gcHJvcGVydGllcyB0eXBpY2FsIGZvciBTUEktY29u
bmVjdGVkIGRldmljZXMsIGV2ZW4gdGhlc2Ugd2hpY2ggZGV2aWNlDQo+IGJpbmRpbmdzIGF1dGhv
ciBkaWQgbm90IHRyaWVkIHlldC4NCj4gDQo+IFJlbW92ZSB0aGUgc3BpLSogcHJvcGVydGllcyB3
aGljaCBub3cgY29tZSB2aWEgc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPiBzY2hlbWEsIGV4
Y2VwdCBmb3IgdGhlIGNhc2VzIHdoZW4gZGV2aWNlIHNjaGVtYSBhZGRzIHNvbWUgY29uc3RyYWlu
dHMNCj4gbGlrZSBtYXhpbXVtIGZyZXF1ZW5jeS4NCj4gDQo+IFdoaWxlIGNoYW5naW5nIGFkZGl0
aW9uYWxQcm9wZXJ0aWVzLT51bmV2YWx1YXRlZFByb3BlcnRpZXMsIHB1dCBpdCBpbg0KPiB0eXBp
Y2FsIHBsYWNlLCBqdXN0IGJlZm9yZSBleGFtcGxlIERUUy4NCg0KVGhpcyBpcyBwcm9iYWJseSBq
dXN0IG1lIG1pc3Npbmcgc29tZXRoaW5nIGFib3V0IGR0LXNjaGVtYSBub3JtcywNCmJ1dCBob3cg
Y29tZSB5b3UgYWRkZWQgdGhlICRyZWYganVzdCBhYm92ZSB0aGUgZXhhbXBsZSByYXRoZXIgdGhh
bg0KYWJvdmUgdGhlIHByb3BlcnRpZXMgbGlzdD8NCg0KRWl0aGVyIHdheSwgdGhlIGNoYW5nZSBp
dHNlbGYgbWFrZXMgc2Vuc2UgdG8gbWU6DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJv
Lm9yZz4NCj4gDQo+IC0tLQ0KPiANCj4gVGVjaG5pY2FsbHksIHRoaXMgZGVwZW5kcyBvbiBbMV0g
bWVyZ2VkIHRvIFNQSSB0cmVlLCBpZiB3ZSB3YW50IHRvDQo+IHByZXNlcnZlIGV4aXN0aW5nIGJl
aGF2aW9yIG9mIG5vdCBhbGxvd2luZyBTUEkgQ1BIQSBhbmQgQ1BPTCBpbiBlYWNoIG9mDQo+IHNj
aGVtYXMgaW4gdGhpcyBwYXRjaC4NCj4gDQo+IElmIHRoaXMgcGF0Y2ggY29tZXMgaW5kZXBlbmRl
bnRseSB2aWEgZGlmZmVyZW50IHRyZWUsIHRoZSBTUEkgQ1BIQSBhbmQNCj4gQ1BPTCB3aWxsIGJl
IGFsbG93ZWQgZm9yIGJyaWVmIHBlcmlvZCBvZiB0aW1lLCBiZWZvcmUgWzFdIGlzIG1lcmdlZC4N
Cj4gVGhpcyB3aWxsIG5vdCBoYXZlIG5lZ2F0aXZlIGltcGFjdCwganVzdCBEVCBzY2hlbWEgY2hl
Y2tzIHdpbGwgYmUNCj4gbG9vc2VuZWQgZm9yIHRoYXQgcGVyaW9kLg0KPiANCj4gWzFdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDcyMjE5MTUzOS45MDY0MS0yLWtyenlzenRvZi5r
b3psb3dza2lAbGluYXJvLm9yZy8NCj4gLS0tDQo+ICAuLi4vYmluZGluZ3MvZnBnYS9taWNyb2No
aXAsbXBmLXNwaS1mcGdhLW1nci55YW1sICAgICAgICAgIHwgNyArKysrLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxtcGYt
c3BpLWZwZ2EtbWdyLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZnBn
YS9taWNyb2NoaXAsbXBmLXNwaS1mcGdhLW1nci55YW1sDQo+IGluZGV4IGFlZTQ1Y2IxNTU5Mi4u
NTI3NTMyZjAzOWNlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZnBnYS9taWNyb2NoaXAsbXBmLXNwaS1mcGdhLW1nci55YW1sDQo+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL21pY3JvY2hpcCxtcGYtc3BpLWZwZ2Et
bWdyLnlhbWwNCj4gQEAgLTIyLDEzICsyMiwxNCBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgIGRlc2Ny
aXB0aW9uOiBTUEkgY2hpcCBzZWxlY3QNCj4gICAgICBtYXhJdGVtczogMQ0KPiANCj4gLSAgc3Bp
LW1heC1mcmVxdWVuY3k6IHRydWUNCj4gLQ0KPiAgcmVxdWlyZWQ6DQo+ICAgIC0gY29tcGF0aWJs
ZQ0KPiAgICAtIHJlZw0KPiANCj4gLWFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArYWxs
T2Y6DQo+ICsgIC0gJHJlZjogL3NjaGVtYXMvc3BpL3NwaS1wZXJpcGhlcmFsLXByb3BzLnlhbWwj
DQo+ICsNCj4gK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gDQo+ICBleGFtcGxlczoN
Cj4gICAgLSB8DQo+IC0tDQo+IDIuMzQuMQ0KPiANCg0K
