Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54F24BB36E
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 08:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiBRHcP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 02:32:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiBRHcO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 02:32:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61962860DB;
        Thu, 17 Feb 2022 23:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645169518; x=1676705518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oDBBcePamn2080sYMD4V6kRYW9yJScbdRd+PFYg5AWk=;
  b=WHcvBuzAk1+2zxw9LCzJ8LFepeMJDfe6+Rv02Id1TocoUKcVAjkbhTjL
   pcGkbNk6y+1JaCsJRUkFR8mH71Bm2kVO8KiiPcWGXxoaQg7vqGB4O9w13
   6H9WT1cMqa0i7dvYxgilhxG6u0kWYTYGOHO4bgooapO4lXcteKcoHTtfT
   qfiZh+O7gdCiPdLMnrQ05PzSboxuHoy3cIefGUvR6xs9wlSS+iroZriY1
   gAfs/X2VhFf9avh0a8VZ60Dio84PYmUZtC2yRLjZzhcPv3Vpu/dfh0qYt
   VO2N+jmNY8OQ6x5fTsjKOPvviSaKHio5815Hro3wYUPzXOyupX2IYpNqy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238476237"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="238476237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 23:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="546161685"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 23:31:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 23:31:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 23:31:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 23:31:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=he5wT0CgwDAB+NyHe6x3QwZ9NJojv0FDIhVtvrRFuL6BRc6ZNokpocHb8zgTTs8cb0ZXr1O92nqtYSZ4Nf4vf07nfww5ppGkhPmA54/7/rerXFbk3GDmb+P7jt8fRVWyw3PmCuZiPwLMWWtHBTnisvHcj5AB+26ZgFom50AoLtF2Z/xDVPPZ7h5RRusgTh78lNfHsjo8KXVZsOTY+GbHZCCMNWhLxGH5nQEg5LAfUloEBKYUEp5UggO5VvCRL/Aiq1BPdq5zuxYeSK4XWxx7sZF1rKomNrNvqzFqgpEgmD5c5UCljswHZvjsyl31AJ1aOHVoyeObpK4AOmMCY51KAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDBBcePamn2080sYMD4V6kRYW9yJScbdRd+PFYg5AWk=;
 b=gtmFnUDuN2W+0NXi91U6Vz6TvH9vp5YnfyKMttUsfvOp8gyp1AR4WVXlKzc5ywkAutylVAeXJ+rUgvcJhSiHJd2MbZNyzK+ExJn2rUuW65cmKMnOCNKyz3MW9KVff4AJ312nA+ScQklmyjRojoDFvE873SacWn6jePtvAH6/sLLmvJb/5/2gVJJwXwVBuBlwUBeSW79HCgY0FiaBa3Fj2nHC/KOgOIvyPjzOIIEoTMxpUc98WncIfIKv370ohqQxCP8sneyOTJ3enS54pyhvsL7kbHFrbJVJNWOv76cBNmjM9Wy1UzXd5YYa0XxUPZ1E202ZIU+38AsLvYxqVK6AcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 07:31:55 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 07:31:55 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Topic: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Index: AQHYIZYvt4gS1fF4bUKEbM/1CaiLCqyUt+KAgAQuCxA=
Date:   Fri, 18 Feb 2022 07:31:55 +0000
Message-ID: <BN9PR11MB548314968CBC0CA5E446B366E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
 <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com>
In-Reply-To: <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d947387-aa87-41c9-649b-08d9f2b0bd3c
x-ms-traffictypediagnostic: CH0PR11MB5316:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH0PR11MB5316B98ECA247CB5572A4D95E3379@CH0PR11MB5316.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itG5pBdV1ALhfgDqZcmH23A0A5OmLZm7G00kUXsSa+BXz+V1UfPow0L21+4lUATyiUVQ704iqsMCNDAsFQe+3J2KRDH7dNgGC//M+TNlgQLkSooSo7H8jN+xbL4lP5rJuL5vO39uoaJAyFQRXpXvEbHfYTj++LiQWQMFnCFuuNP4mat4pXFZgb5s9kAv/4iw9OPRbOFe7Kq6y2HmT9Wetqnn5Q3XrZ4QuKO7HXDEFXHS4BDd+oRAMH5VHVZYB9A8Ka2N+xwTKwXdA//U2s6a85QcLOuNtPFqdvE7y7RI7Z30Caw0vsx3LpO4RtBFOXqGCHhcSvlTa+N5A5oBwgkTNkKSdy+58JLOI3lAl8NM38+mHbtvkg56dgvPrOKl6pQjlfrpRiusRj1Ibjna/rp8cZ2OTGkxDBp5sMHBBW3nkn+0csEprnCpoECj1Fsey9q4lunPMqKvvTqUlyODhOysuLcfsBNer9yxU4Jh00X0uNVdeSGOpkhY8eV4NdGYNewH/ly7ryMnLznLhgJHTuOFKWJMqFZ1dG5zbYiTQ+Yssu13tpHJGeeDyeNZxnN+72nTBOWCYiVcOYyc7mKzAWNrCfmAPh6blnPRCkCHXK00fgkMaqW6C45cp8QKTWlQyKCxGSrx2OB5BKUi5o53bWCvgbW80L3GbbKd/n9bzaAi1CZu77JaLZGcH1IibYJHEvbKOMnUxTrtOT0616anYnPC7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(2906002)(66946007)(66446008)(66476007)(86362001)(316002)(76116006)(38100700002)(52536014)(82960400001)(122000001)(64756008)(8676002)(8936002)(4326008)(38070700005)(5660300002)(53546011)(33656002)(26005)(508600001)(83380400001)(186003)(55016003)(9686003)(6506007)(54906003)(7696005)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlNjR0tlakFGdFhYMzZtOHprU1QzRzRESFpGUzlyWG02YjdDMHhCaXRrMzE2?=
 =?utf-8?B?SzJXQWV1S2ZwZ0ZzZzlQMVRwWTh5OUNzdW9aWkZYbU12TzREdHYrOWF3ZGp3?=
 =?utf-8?B?eDQ0dFRFdFpoM2RKcEl6RXBUemkwUUNUSkFPaU1RQTA0VS9JcUhHUldBcEJ2?=
 =?utf-8?B?YTVDczR4ejFuUzE1RktDTlRudjBhYk51ZUR1MmFLNmdIMVJLYVhTK1JQS3ZY?=
 =?utf-8?B?alNEazBMVW1WOFBsZThXeHhNQ1g3USszaDlpYXlCYWIvRTkwV3d1Z3dXNENQ?=
 =?utf-8?B?eWo4a3AwWGJQN0lWRzVNM3l0Z09zRlpnYUxiRWZXL0J6bWo4RVcxajc3c1Fl?=
 =?utf-8?B?L0g2NnUvcFB3dXFvZ0xjUS9sNkN0ayttVGpCalNVV3lSdVRQN1p3RTJsb3Vy?=
 =?utf-8?B?eEhPaFNDRU1ML0JDWU9pK2RESlQrcHhWL3BYSk9Rb3IySTFhbFJsdCs5Mi8v?=
 =?utf-8?B?bE0zc3BjZE9PdTBiWkludGQ2ZHBCYXRmVEt2QTQrNG1nWXpBZ3NiME1peWs0?=
 =?utf-8?B?aXFOc25OOXo1R0cyVWhYMytrWmp0TkpjZ3l3VlcyVlZOdTF6V0h1QlBRRkd0?=
 =?utf-8?B?azRENElsQUtjK2hBMjlhNXJ4RUR1M3pUeDBvNGlQTmp4VmJtcmg5Y1NMS1ZX?=
 =?utf-8?B?b0ROMDNLZjZKaHF2ekZhYzM2cnMrZlpwU1hIbG9TeEs1NTJQUS9lSkUwWmk3?=
 =?utf-8?B?ZGRCWEhSa0FuL3dQY1lmVU9KUFp0WTBZNzZ3VjlmanRWY2wyUEYvRUlXeXdu?=
 =?utf-8?B?YW5uWGdlMjU2KzlLRXVnYmppR2Ezc2FFNWhpdWNuNDFKRjlDODR6OGJ4NVpa?=
 =?utf-8?B?djdpM2FNcm1ZTkxNbitCSUNuMEoyM2o4dDBYU0lvd1hsSFQ0N0gxeTBZUzB2?=
 =?utf-8?B?cTBIaXEyVkVnaWhrMkFjbnZ3UTRRbmRPRlhZUXVMOHFOZzNScDB5TDQ3cCtM?=
 =?utf-8?B?UXFjMU9xMUUwYWtOSnZ4TkJnSFhwTzh1anppTVlYOUMraFRWTWFoVnphRDA4?=
 =?utf-8?B?dlNYOW5UWXF5SkV3WkpMcGY5eW40THJNVDN4Vk1jRXZmekF3T2ZQWloyNUxE?=
 =?utf-8?B?emNQeW1CK0dCUU1lblFIMFNvTExEZHo4YjVwUzNFMXVWS3hwUjh1cnpYQllD?=
 =?utf-8?B?eWNZNW02bFAwUUVoV25lYVJTU0hBU09IWStUT3BacUNBZCtmT24rNVQyZTFo?=
 =?utf-8?B?Ny9wdHluTE5USDhYaTlLYTIzcG5IN1BOd1V4T2YzNUJiT0xGdTVUY0c1OUJX?=
 =?utf-8?B?YjdkYkMxZVJ2U0pSTjJ3Qm9wS1ZjZVJRT0JWNDFSYThNbDByOGtTQTQzM1A4?=
 =?utf-8?B?Ti9wcmFaQ09VUkJ5dzQ2Vk80MGpnTXFBM3Ztd1VaZ1J2VkQzVHpBRTIrK2NZ?=
 =?utf-8?B?dk03VzNqdXhqM1RsTkZLWk00aXRRTmszaG9wS0pWWkJvaDJTbHdVck8wOFVl?=
 =?utf-8?B?OHE2aUlvODVpRzE5eS9VajM0R3F0akxjcnA0Nm80czhGNVVnZWtaWEZ1YzFq?=
 =?utf-8?B?TWdUZEZTZkxZdUdTdkpkMkJabFp6Mi9EbUZKS2pBNXRmUnNmMGVGYVEvbjJQ?=
 =?utf-8?B?ZHF2WGc0N0NyeXVUQ3o1R3lFWFBTdHA2eloxc2wzNGw1OWRuRStwalppdkhS?=
 =?utf-8?B?c3hmd0VKTUlPQVA0NUl6YStTTTdZcWNKbDBxdExaOVFXWEpEWHp5MmJLS2F2?=
 =?utf-8?B?NkN2QlV1Sk1sWlJCNXBNLy9YeUpaLzh0NFJmbHE3aE9xYU9BOUJpWk42TWMy?=
 =?utf-8?B?MnNmY2pXNTVnd00zbFkzclB2elRMbkxtVTY5aWlYTlZ1V3JKZllTcXgwN1BW?=
 =?utf-8?B?QnNMVHV2dVhWeElaS2gyMFl6TWZFcE1xRzhRMmdVNkMyMEV4T00vMW9qSG5L?=
 =?utf-8?B?NkFoZWVzSmM1NytQK2pqd3RjTzFVRmE5Ni9WaWJyNFB2WW55Tno4VG1UbTVt?=
 =?utf-8?B?UGdpdG1EZlh1V2tQcWNSOG5ONVVkZHJjSEd5MTdVdkhyUXM0Y085eXVZSHRk?=
 =?utf-8?B?RU1mSmpQZlNpMlRsT1hJZGIzZ2ltUFJyRlhEV0llZC92NTdiYkliVzdwampT?=
 =?utf-8?B?cTVlS2RFLzkvakNWQ2s2RGpDTXdNNTN2S2R2WS81dmdvWmpBM21reVNQNENY?=
 =?utf-8?B?cDlDYkNHQ1c4QmsyMC92SGJTV2w2QnM0M0Q5RTh2ckZzN0hheGlyVzlCR3NN?=
 =?utf-8?Q?r+F2lA/Ombank2bo8YmX0Wk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d947387-aa87-41c9-649b-08d9f2b0bd3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 07:31:55.1559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAgVjYV0O+zbSIUewyvKx6wed3XgQ17Xht9XGPZhPtNDJVUheBSHSFwJGcdXabVV0vkMR/dpfurkputaMuVBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMiAxMTowNiBQTQ0K
PiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgV3UsIEhhbyA8
aGFvLnd1QGludGVsLmNvbT47DQo+IG1kZkBrZXJuZWwub3JnOyBYdSwgWWlsdW4gPHlpbHVuLnh1
QGludGVsLmNvbT47IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1kb2NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBjb3JiZXRA
bHduLm5ldDsgTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDMvN10gZnBnYTogZGZsOiBBbGxvdyBmb3IgcG9y
dHMgd2l0aCBubyBsb2NhbCBiYXIgc3BhY2UuDQo+IA0KPiANCj4gT24gMi8xNC8yMiAzOjI2IEFN
LCBUaWFuZmVpIHpoYW5nIHdyb3RlOg0KPiA+IEZyb206IE1hdHRoZXcgR2VybGFjaCA8bWF0dGhl
dy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPg0KPiA+ICBGcm9tIGEgZnBnYSBwYXJ0aWFs
IHJlY29uZmlndXJhdGlvbiBzdGFuZHBvaW50LCBhIHBvcnQgbWF5IG5vdCBiZQ0KPiA+IGNvbm5l
Y3RlZCBhbnkgbG9jYWwgQkFSIHNwYWNlLiAgVGhlIHBvcnQgY291bGQgYmUgY29ubmVjdGVkIHRv
IGENCj4gPiBkaWZmZXJlbnQgUENJZSBQaHlzaWNhbCBGdW5jdGlvbiAoUEYpIG9yIFZpcnR1YWwg
RnVuY3Rpb24gKFZGKSwgaW4NCj4gPiB3aGljaCBjYXNlIGFub3RoZXIgZHJpdmVyIGluc3RhbmNl
IHdvdWxkIG1hbmFnZSB0aGUgZW5kcG9pbnQuDQo+IA0KPiBJdCBpcyBub3QgY2xlYXIgaWYgdGhp
cyBpcyBwYXJ0IG9mIGlvZnMgb3IgYSBidWcgZml4Lg0KDQpUaGlzIGlzIHRoZSBuZXcgaW1wbGVt
ZW50YXRpb24vZmVhdHVyZSBvZiBJT0ZTLg0KT24gSU9GUyBzdXBwb3J0IG11bHRpcGxlIG1ldGhv
ZHMgdG8gYWNjZXNzIHRoZSBBRlUuDQoxLiBMZWdhY3kgTW9kZWwuIFRoaXMgaXMgdXNlZCBmb3Ig
TjMwMDAgYW5kIE41MDAwIGNhcmQuDQpJbiB0aGlzIG1vZGVsIHRoZSBlbnRpcmUgQUZVIHJlZ2lv
biBpcyBhIHVuaXQgb2YgUFIsIGFuZCB0aGVyZSBpcyBhIFBvcnQgZGV2aWNlIGNvbm5lY3RlZCB0
byB0aGlzIEFGVS4NCk9uIERGTCBwZXJzcGVjdGl2ZSwgdGhlcmUgaXMgIk5leHQgQUZVIiBwb2lu
dCB0byB0aGUgQUZVLCBhbmQgdGhlICJCYXJJRCIgaXMgIHRoZSBQQ0llIEJhciBJRCBvZiBBRlUu
DQpJbiB0aGlzIG1vZGVsLCB3ZSBjYW4gdXNlIHRoZSBBRlUgQVBJcyB0byBhY2Nlc3MgdGhlIGVu
dGlyZSBBRlUgcmVzb3VyY2UsIGxpa2UgTU1JTy4NCjIuIE1pY3JvLVBlcnNvbmFzIGluIEFGVS4g
DQpJT0ZTIGludHJ1ZGluZyBuZXcgbW9kZWwgZm9yIFBSIGFuZCBBRlUgYWNjZXNzLg0KTWljcm8t
UGVyc29uYXMgYWxsb3cgdGhlIFJUTCBkZXZlbG9wZXIgdG8gZGVzaWduYXRlIHRoZWlyIG93biBB
RlUtZGVmaW5lZCBQUiByZWdpb25zLiANCkluIHRoaXMgbW9kZWwgdGhlIHVuaXQgb2YgUFIgaXMg
bm90IHRoZSBlbnRpcmUgQUZVLCBpbnN0ZWFkDQp0aGUgdW5pdCBvZiBQUiBjYW4gYmUgYW55IHNp
emUgYmxvY2sgb3IgYmxvY2tzIGluc2lkZSB0aGUgQUZVLg0KMy4gTXVsdGlwbGUgVkZzIHBlciBQ
UiBzbG90Lg0KSW4gdGhpcyBtZXRob2QsIHdlIGNhbiBpbnN0YW5jZSBtdWx0aXBsZSBWRnMgb3Zl
ciBTUklPViBmb3Igb25lIFBSIHNsb3QsIGFuZCBhY2Nlc3MgdGhlIEFGVSByZXNvdXJjZQ0KYnkg
ZGlmZmVyZW50IFZGcyBpbiB2aXJ0dWFsaXphdGlvbiB1c2FnZS4gSW4gdGhpcyBjYXNlLCB0aGUg
UG9ydCBkZXZpY2Ugd291bGQgbm90IGNvbm5lY3RlZCB0byBBRlUgKHRoZSBCYXJJRCBvZiBQb3J0
IGRldmljZQ0Kc2hvdWxkIGJlIHNldCB0byBpbnZhbGlkKSwgc28gdGhpcyBwYXRjaCB3YW50IHRv
IHN1cHBvcnQgdGhpcyB1c2UgbW9kZWwuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhl
dyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRpYW5mZWkgWmhhbmcgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0K
PiA+ICAgZHJpdmVycy9mcGdhL2RmbC1wY2kuYyB8IDggKysrKysrKysNCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zw
Z2EvZGZsLXBjaS5jIGIvZHJpdmVycy9mcGdhL2RmbC1wY2kuYyBpbmRleA0KPiA+IDRkNjg3MTll
NjA4Zi4uOGFiZDliNDA4NDAzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZnBnYS9kZmwtcGNp
LmMNCj4gPiArKysgYi9kcml2ZXJzL2ZwZ2EvZGZsLXBjaS5jDQo+ID4gQEAgLTI0Myw2ICsyNDMs
NyBAQCBzdGF0aWMgaW50IGZpbmRfZGZsc19ieV9kZWZhdWx0KHN0cnVjdCBwY2lfZGV2ICpwY2lk
ZXYsDQo+ID4gICAJCXYgPSByZWFkcShiYXNlICsgRk1FX0hEUl9DQVApOw0KPiA+ICAgCQlwb3J0
X251bSA9IEZJRUxEX0dFVChGTUVfQ0FQX05VTV9QT1JUUywgdik7DQo+ID4NCj4gPiArCQlkZXZf
aW5mbygmcGNpZGV2LT5kZXYsICJwb3J0X251bSA9ICVkXG4iLCBwb3J0X251bSk7DQo+ID4gICAJ
CVdBUk5fT04ocG9ydF9udW0gPiBNQVhfREZMX0ZQR0FfUE9SVF9OVU0pOw0KPiA+DQo+ID4gICAJ
CWZvciAoaSA9IDA7IGkgPCBwb3J0X251bTsgaSsrKSB7DQo+ID4gQEAgLTI1OCw2ICsyNTksMTMg
QEAgc3RhdGljIGludCBmaW5kX2RmbHNfYnlfZGVmYXVsdChzdHJ1Y3QgcGNpX2RldiAqcGNpZGV2
LA0KPiA+ICAgCQkJICovDQo+ID4gICAJCQliYXIgPSBGSUVMRF9HRVQoRk1FX1BPUlRfT0ZTVF9C
QVJfSUQsIHYpOw0KPiA+ICAgCQkJb2Zmc2V0ID0gRklFTERfR0VUKEZNRV9QT1JUX09GU1RfREZI
X09GU1QsIHYpOw0KPiA+ICsJCQlpZiAoYmFyID49IFBDSV9TVERfTlVNX0JBUlMpIHsNCj4gDQo+
IElzIGJhciBzZXQgdG8gYSBiZXR0ZXIgbWFnaWMgbnVtYmVyIHRoYXQgcGNpX3N0ZF9udW1fYmFy
cyA/IG1heWJlIDB4ZmYncw0KPiANCj4gSG93IGRvIHlvdSB0ZWxsIGJldHdlZW4gdGhpcyBjYXNl
IGFuZCBicm9rZW4gaHcgPw0KDQpZZXMsIEkgYWdyZWUgdGhhdCBtYWdpYyBudW1iZXIgaXMgYmV0
dGVyLCBDdXJyZW50bHkgdGhlIFJUTCB1c2luZyBQQ0lfU1REX05VTV9CQVJTIGZvciBhbiBpbnZh
bGlkIFBDSWUgYmFyIG51bWJlci4NCg0KPiANCj4gTW92ZSB1cCBhIGxpbmUgYW5kIHNraXAgZ2V0
dGluZyBhbiBvZmZzZXQgdGhhdCB3aWxsIG5vdCBiZSB1c2VkLg0KDQpZZXMsIHRoaXMgbGluZSBp
cyBub3QgbmVjZXNzYXJ5LCBJIHdpbGwgcmVtb3ZlIGl0IG9uIG5leHQgdmVyc2lvbiBwYXRjaC4N
Cg0KPiANCj4gPiArCQkJCWRldl9pbmZvKCZwY2lkZXYtPmRldiwgInNraXBwaW5nIHBvcnQgd2l0
aG91dA0KPiBsb2NhbCBCQVIgc3BhY2UgJWRcbiIsDQo+ID4gKwkJCQkJIGJhcik7DQo+ID4gKwkJ
CQljb250aW51ZTsNCj4gPiArCQkJfSBlbHNlIHsNCj4gPiArCQkJCWRldl9pbmZvKCZwY2lkZXYt
PmRldiwgIkJBUiAlZCBvZmZzZXQgJXVcbiIsDQo+IGJhciwgb2Zmc2V0KTsNCj4gPiArCQkJfQ0K
PiA+ICAgCQkJc3RhcnQgPSBwY2lfcmVzb3VyY2Vfc3RhcnQocGNpZGV2LCBiYXIpICsgb2Zmc2V0
Ow0KPiA+ICAgCQkJbGVuID0gcGNpX3Jlc291cmNlX2xlbihwY2lkZXYsIGJhcikgLSBvZmZzZXQ7
DQo+ID4NCj4gDQo+IElzIHNpbWlsYXIgbG9naWMgbmVlZGVkIGZvciBlbHNlLWlmIChwb3J0KSBi
bG9jayBiZWxvdyB0aGlzID8NCg0KSSB0aGluaywgdGhlIGVsc2UtaWYgaXMgbm90IG5lY2Vzc2Fy
eS4gSSB3aWxsIHJlbW92ZSBpdCBvbiBuZXh0IHZlcnNpb24gcGF0Y2guDQo+IA0KPiBUb20NCg0K
