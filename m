Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277D54B5E43
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 00:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiBNX23 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 18:28:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBNX22 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 18:28:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9269FABC4;
        Mon, 14 Feb 2022 15:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644881299; x=1676417299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=93NC8urXNxmx+jBkfS1e/YKVj41fJ3mJekQJ4cYiYDQ=;
  b=SMs93lw+dKE21rjpWzezH3vGqxoxIK30DfNoJc4erC9Wi5/nxVvbyn/f
   4n1fErI8Ly5tyxYhqb3nZo5wEARgyZsIKwoLMZcgr16q2lzfagiIqmmpN
   Z8RuRDKBAmTUpJO2shrb7xWn/1fxaKYBo2+09VIQKoiSU3Fq7cgdcCxdA
   gv18rNCpmbPEiiR64hpPpBWrc8+tgOTq7Y+zZDM+J+4d7ican/7+wwP3J
   lBSrBOC1O6UOS3jG7Poohrk03NPMAepmRiWKKKVChzOqQ3TpMmR/X/N1b
   QTs6hmzW4FWZ+oZ6T4pUXvbHTMwUaebTcrcJVr1T0cIGijPBFN2Ktd59g
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249955510"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="249955510"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:27:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="528499988"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2022 15:27:57 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 14 Feb 2022 15:27:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 14 Feb 2022 15:27:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 14 Feb 2022 15:27:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1Ezc7dtvnO4lt6yPMjzZrokAA4uZZ9bHqANDVIpn2EyAowj6YSkCG5XiqOldEsh0f0rte4AGnh39UKdE9dDQ3xnfvBrAY1L99W51Q8Lg6bJP9YQju4g2/D+Jt0rOt2TuEIPBBZ4MqyXaupgXJM5jFwilVFyzTxCcK7FXFRHh0Nd/0A0DPe1e8g73l6H5PraXckDE30+vdqLiDz7RQiJigO7RUmjoADmn0CNadvukfJkXIk3t/tRcqRwZUANOr4NDWgcmiqRFfHGqyhwqa78nAVFIefuJ+ThOitSehNwf5INgtRFN4JruLK0Z8dFzb4Aw06FqIAxXOE9NhmzID2cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93NC8urXNxmx+jBkfS1e/YKVj41fJ3mJekQJ4cYiYDQ=;
 b=IJEhw3IHmoA6wgb1c3PS8JEB6M8UBlJhlM2898Qidyz24fta6pdOMdekZAIWhuRk41zFwXHKexwj/8Hhs8NwdkrE0e/DQR9gDEcZI0G6AILsWmkJOsr9SZVc1gHcbIUnliK+U/Mr+uKIa0jScQHZL4l/pEap1sTSN2LGA5Pmwv6/gFhVLMQd65CrdWfsOyLBe21LUyW3dED9bTq1vjPkippEIW83alKcf4RQR1CN0yNmBAcu4MfvVrJ4/evjiMi8nyMF1J7gzBVI44tmYpBdcO/io+tcohN9Jy0M3yxxqZBOAzjb3ILIPgbjzyzLLOAlJHICs1rSGNo4PtFHQSEByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SN6PR11MB2704.namprd11.prod.outlook.com (2603:10b6:805:53::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 23:27:52 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c8ff:c95c:e601:eee3]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c8ff:c95c:e601:eee3%6]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 23:27:52 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Thread-Topic: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Thread-Index: AQHYIZYrI9khWBzXDEChcSjUIMBh1qyS9toAgABeawCAAFxVYA==
Date:   Mon, 14 Feb 2022 23:27:52 +0000
Message-ID: <BN9PR11MB548353C757E2B7247C0733E3E3339@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-2-tianfei.zhang@intel.com>
 <eb5506aa-815d-b373-2eff-a3b9df533141@gmail.com>
 <be378318-2b68-15d3-df89-db5b10ccc8cb@infradead.org>
In-Reply-To: <be378318-2b68-15d3-df89-db5b10ccc8cb@infradead.org>
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
x-ms-office365-filtering-correlation-id: 4ac1ee99-4f87-47c2-19e5-08d9f0119f51
x-ms-traffictypediagnostic: SN6PR11MB2704:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB27049F784CDE5819EED5AF5CE3339@SN6PR11MB2704.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFh9UVxHx/1yMSC09DHdoOJwK9ttQP4tVMlgGftkiLXRlcswAvJP7PPpp4UyDEYpknxaR97CS8+5JqSoU03UUdNy5aOGvTCnOV/t2aIRKH04QGvc4XCGjCt7AglPnRWozvtqYoMU2ZWq1CXMqfyvKgEBJFe8/aJ3wdv2KXmguJ+AZk6EiJ3Daotrt9JZLlM1MVo7eJbA1xIUmiRUPGlmZIJd/ywaNRQOhsLmk5Nitz0kPlHT+2BDhvl1F4JSBjrnWS2EPl16WswARpVV1XK2fr+jkgswNcoJleLX48pspFtK3n+rnUYYEMNjzB6hL07LVWuuDDM6VsBxLSfU29JRu6N76GcB7ckAGuKJAVzEMWsdeer5J6jsnlfdahiaC1R7Kp5OMGXHxqkUm9JjtCtg/1saFFhnCJGxtVlVw3pBv0sn8RzBGvHufleZitc/t7BLvjuJFt+JJmgfcjqM8YqJvF7/xH1vQVmB7JnNWFakCv5c5Mt/SoZM1UkLBaeJjKDr+PJaSyCh3jJnOODxg2PJHPDqbxHWvfKgYOXoeTDQMe3fcYMGmxuxqDd4KFnwKJxMQLuVjsasKJZUTTViXbZITI3dgiCkg3jrEg85nnWV+ZsRdGVkmRz5Vca1oLYBdkyMKet9254xlpesWrni/rXwY6krjmL3AAYQzqPDcq95yslLVmnn4Y1whVDhGKxt+Yu+nho3tNQE9S8HfsVrMFirBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(7696005)(83380400001)(110136005)(316002)(71200400001)(508600001)(6506007)(9686003)(86362001)(5660300002)(38100700002)(186003)(2906002)(33656002)(55016003)(107886003)(8676002)(4326008)(53546011)(66446008)(66476007)(64756008)(66556008)(122000001)(66946007)(82960400001)(52536014)(76116006)(8936002)(4744005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWhhWWMzZTZuczIyWXBVNGFOMURwN2RXcHY0dVhvc1lCVWxyMEF5a2lLcFlT?=
 =?utf-8?B?eHo2dmszRitGamhjZG9jZDA5bFRaSENhY3ozYlBWUlVtbDFmM1pJZkxHWWZ0?=
 =?utf-8?B?cFF3Sk5McjJMR0t0Y3FWdWY4NjZUejA3VnIxK2d3NXZhbUh5V0Q1Ympxbm96?=
 =?utf-8?B?Z3NPSXB3SVhISmZpd25Ja25TWHV5d1YvOTk2ZVhHNWlwc3lXRi95Nll0Vjd1?=
 =?utf-8?B?UVJRZXRUY1BIYndOc3NDdWg0alhocUJsbXVxT3ZwZmpaQ0UxdjhlTEVKMEs1?=
 =?utf-8?B?TTNpQ0JZVEsvVm5hVHpVMmN4dUwyZGNQQm5YY3BKUUlyUUw4dk5nOTl0c0Ja?=
 =?utf-8?B?TzNKS0RrYlB1djZmMzRvMGR6eEhWcnB3NEx3YUI4ZU1NdDRtK3J4WTZONnpv?=
 =?utf-8?B?QkU3bTFLNVA1ZGpMMnJGeU4zTmNFSVIydGloVG1rc0I5UnVsbGxHYTdTeUlh?=
 =?utf-8?B?d3hDelRtMGVzeU5ONWlZd1BONmwzVjBNS0lqeCtsMkcrTE5FNGIzMGR5QnJt?=
 =?utf-8?B?bFlwc24xTlZaWG4xSjFKR0Z6QjVxQ1NqK1lWd2U1TnRBWUFUdUU3NnJ3NWIy?=
 =?utf-8?B?ZWdYSFpoWHhiaThHTDlLTWtRSlFoa2ZLNGtQZ1dIQ0MxcWVaUjhHcmxJdkpF?=
 =?utf-8?B?VFhNM2lnSmJnOEsrelRBNGZ5OXNtc0pDa254a3ZUeER3T3F4QlhHVGpnblNZ?=
 =?utf-8?B?ZTlwQmYxdFRmY0QvdnRTTUZ5OFp3TEZpN3JSZ2F3a0tteWlGQTNLZmo4ZnI1?=
 =?utf-8?B?RlRQdjZJN2gzaE5FSlVpMFh2MmE1ZlUrWXpCSVFKWmRQcnZUc2g5Sy9Hby9v?=
 =?utf-8?B?VktKTklUVjBEMEdZcGFIMHhkK1k4QVVkU01QTWp4R3FPWFdBQmZMeTExbGpC?=
 =?utf-8?B?ZXJHbHJhUFBqSVN2V0lOTmg1NFNGK2JacEYwZE1FMmc2b01MU0JYckdlOTh6?=
 =?utf-8?B?QUVFeGdqQmZ5OHBFL0QxaWlSKzQreWVJaG5XU2xGb1N1WnFheU91UndzcVli?=
 =?utf-8?B?RDVqMVJuTlFzMjdMS3VXbDNIcWFSREMvNHpIcEpYUEhzV2Z6eWhDSmdhMkV2?=
 =?utf-8?B?dzZ1K3lrSExZK0hEWkZlSU9lb2JHOFVzWG5wQTNtanc5OE8wZk90a3ZtTGhi?=
 =?utf-8?B?TTRsK3JuY253MDJnbktKczE4YitiZ0QzejJtbnBXb1lNV0J6aS9NeUNnWjZq?=
 =?utf-8?B?bkNDRUJNL0Q1d2owcFFOcC83SjJIdkRWcWw5SWhrejh5RDhaZGw1NDl5OVRR?=
 =?utf-8?B?VlhVNTF5NjdmeGpBeDVLOHYrQlpuams3M2JyOEpSWGx3K1VDUENMQTlGZnZK?=
 =?utf-8?B?RE5YaDlWR0hMSGFMdkpPRXNqS2xLc0RtMFlhTVFpdHlMQ2dFMml5dHRROWJT?=
 =?utf-8?B?cmRjVEFoMEVYRWQrNkhqbU1xdjJjY0dKbVdNY2JmTUJmWjBvcmpvc2xEK20v?=
 =?utf-8?B?RDRDb0w0N0NYZ0w2Ri9WZTNKSkZ1ZFF3NGhRMUlWNThvUVNaR1RuNXQ2d1Fw?=
 =?utf-8?B?dzVvek5kYWlUWDlhbXEvcXdYV1VmOG4vR2x6K0k1eDJOUGREZ05VODN2RStw?=
 =?utf-8?B?Nm1ZTmdaOEExTXFiS05hZ3ZPdlFxQUswV2xPckJSYVcyYVJ1MWxieFcvYnli?=
 =?utf-8?B?Wm9OOEJRRjc0NFpwNFdaNFlQS1plV3JGOUtCNDhoem0zcUh3QWR4Lytpa1ZL?=
 =?utf-8?B?Qm9hc0tNZ1lmaE1ZVWlDeXVkdmJmUHJ0and5VGY3aHB0aEFNdmx6MVhxQnpN?=
 =?utf-8?B?NVViWTlWT1lMaUVQZUlLUS9YWGNJZGV4YktkSTRCWnRJM2VLT0VmWG0yL1Q0?=
 =?utf-8?B?cXRaekY0b3BtZWs4YTQwdmZ2U1JKcWhlVVpYcVltNlZWaUNpUWZZYWE1eVFD?=
 =?utf-8?B?WTJqV3pqdlovQUgvL0xUUmR1ajJ3MXFYY3ZzT3k3U25KSVVIQjhvQThHeXQv?=
 =?utf-8?B?SWpWYnJYbWlCbFRZdDIvVzcwZys5S1NUcXBvbFFrbncvaEk1ZU1BMk56VXZP?=
 =?utf-8?B?aGJRSXlJNHFCRUczNVBwMXA2N2RsUGI3RGpuQkNodzVicGRmZVo1UzNEVUJ5?=
 =?utf-8?B?eGhnMjI1TDRPVFRaMTB2Q2NuTlRHT3lvV2RINWo1TDRPWlRJbStRT0trZlVk?=
 =?utf-8?B?dHIySHJPcUVBeUFyNy9ZSTFUL2dVRWVLQ0lMZnJsMzE5Y0hOMEVUcnY3cG16?=
 =?utf-8?B?WGlQejZ3SWN2OXpjc01ZVDc1UGtYT1lBa0w3Mk1ZTFlyRXIxdExRUWRNWERm?=
 =?utf-8?Q?itm+UqZJTvo0OXn9HG6tuDDKIpG7GDtFlfMhS/gVmE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac1ee99-4f87-47c2-19e5-08d9f0119f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 23:27:52.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFfAUsy7PZPUxcTGtpJG8pw5CuxJeQvYO9po3MVcidLdEEwHvDT6zuIdsK+bKTy2o/LqlAce6TL8Zto0cS+sOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2704
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMiAx
OjU3IEFNDQo+IFRvOiBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNvbT47IFpoYW5nLCBU
aWFuZmVpDQo+IDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT4NCj4gQ2M6IGNvcmJldEBsd24ubmV0
OyBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPjsgbGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbWRmQGtlcm5lbC5vcmc7IHRyaXhAcmVkaGF0LmNvbTsgWHUsIFlpbHVuDQo+IDx5
aWx1bi54dUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS83XSBEb2N1bWVu
dGF0aW9uOiBmcGdhOiBkZmw6IGFkZCBkZXNjcmlwdGlvbiBvZiBJT0ZTDQo+IA0KPiANCj4gDQo+
IE9uIDIvMTQvMjIgMDQ6MTgsIEFraXJhIFlva29zYXdhIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+
ID4gSnVzdCBhIGNvdXBsZSBvZiBuaXRzIG9uIFJlU1QgZm9ybWF0dGluZy4NCj4gPg0KPiANCj4g
VGhhbmtzIDopDQo+IA0KPiANCj4gPg0KPiA+IEknZCByZWNvbW1lbmQgcnVubmluZyAibWFrZSBo
dG1kb2NzIiBhbmQgc2VlIGlmIHRoZSBwYWdlcyBhcmUgcmVuZGVyZWQNCj4gPiBhcyB5b3UgZXhw
ZWN0Lg0KPiANCj4gSSB0aGluayB0aGF0J3MgIm1ha2UgaHRtbGRvY3MiLiBCdXQgcGxlYXNlIGRv
IHVzZSBpdC4NCg0KVGhhbmtz77yMSSB3aWxsIGZpeCBpdCBvbiBuZXh0IHZlcnNpb24uDQoNCj4g
DQo+IC0tDQo+IH5SYW5keQ0K
