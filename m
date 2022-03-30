Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39274EBB60
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Mar 2022 09:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbiC3HBG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Mar 2022 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiC3HA6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 30 Mar 2022 03:00:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C99DEB8
        for <linux-fpga@vger.kernel.org>; Tue, 29 Mar 2022 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648623553; x=1680159553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0+DHCZIU1vHjJJBJUahT+w4qVMtMdXZBvR3cKuXUwY0=;
  b=IWb+QkhvWtSBcbO/Q7qxPpKWQ2DCvHJOevD8hu+LnRFZdbsfDkoGuBq1
   UorgR0qMS0PPpBorveR7siTlqiOiL8w5MJCmaXFGvSsf2AlcBj+Z99Dw0
   l/2KIOgn71JE4GYaYPsLhhP4jljR1QnY0ATEDn+s2vPzBS9c1KIuaZLb3
   OLMWx1fsfdJSCVRKFeUTJp+urScf7sbpDKjvXCHS9Y7CdX82j7eAyl1Y3
   ggh5e4fE98Tw7bkcyy2Ownu6kobdCzKjLGZcJjdlA93Si0I4TtAlsuCV7
   cyJ1dOM6YjAC/cEnATltIuMGyWXp5V5lF2E4TOXmU8cyOceBizmc4bbob
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241620408"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="241620408"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565345351"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2022 23:59:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 23:59:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 29 Mar 2022 23:59:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 29 Mar 2022 23:59:11 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 29 Mar 2022 23:59:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZVVRXGkFX5S+tS2zCNTl64r2lso1Qj4muYN5J2/czeotQkoPkoOltDFnLvGWHdcS7sOycp4M8IQOyIA2lD1JWwx+Ksg2YURbbEL2EVutO6SjiN4h4TDIjGkJnKmqJXrLbJVIuC1Dup6Aq0oqbOzX+bTaVhepM9ofBi8w5WvDaU3TJ2ptBdEA0YI0IoMFhLJw+GcNS8mEYK7f2SVMNtcVfgd1VesbqB5se/xwnzkdnenD9yaMxuM4lNPomDez6tNPRXhZKezDQZesv8wQgYEc2ndooijE4K1OOKpvwpKgzVT5Zm5/DRhXN5pSgWDKjBX9s8qlAp37Jsa9S4aQ836Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+DHCZIU1vHjJJBJUahT+w4qVMtMdXZBvR3cKuXUwY0=;
 b=J0zsKs4sklAd6ZjWx87D4ekauRL8YvF2I5TqothNJdOICAFGwHvXRnS8bZFEV7RyEBx6okUyHViZt1VaSyo4+df6PrXkFHzG8GUKEniqHTTV2AXDMfSxVojluOFifrrfNJtf4+gztD/sBpuzf9TItVSoswzXrYDvfCwcif4ty7rtvRLYpfn86Gz4RXXwuqF9jzi7QxnJrfz9p8cOrGpV3IzJi8quQPN7Y3zH7gzWdjQelWxRh5MvRAq6WB9oStj2RN0FdiIh0m9AiXsSlcSsXAg1Q23cFstdnBM8yPFIPqh2cM7ILdO7xAkrqGiFn22PrF6LMlOZYbqjuZ5ukuhviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 06:59:07 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5123.020; Wed, 30 Mar 2022
 06:59:07 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Xu, Yilun" <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v1] uio: dfl: add HSSI feature id
Thread-Index: AQHYMrhKml+FZWGpG0uUYk5qH7zFV6y5BeCAgAB5IgCAADjzYIAEhEiAgABuVrCAAY8JAIAAC8LwgAKEsgCAFNdJMA==
Date:   Wed, 30 Mar 2022 06:59:07 +0000
Message-ID: <BN9PR11MB5483B539DC495DF929F7E816E31F9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483A25DF3AEF87F83AA4A9DE30F9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819F9A80C12E0253ED1594B85109@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BL1PR11MB54772E1517EEE39B1091836EE3109@BL1PR11MB5477.namprd11.prod.outlook.com>
 <BYAPR11MB38167BB8881D050DE53DDE6685129@BYAPR11MB3816.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB38167BB8881D050DE53DDE6685129@BYAPR11MB3816.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f709803-7262-44b3-bc50-08da121ac8e7
x-ms-traffictypediagnostic: PH0PR11MB5080:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB508007CA8C03252FAF0E16B8E31F9@PH0PR11MB5080.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhYv9x75+m0LrqZLEz65V9oD1AefF26aDbp+6ko+IKHVD25CNDiCwtJd2hd0L/rqWsDG2hfGQIA6g/K4L88sjmTPUh3lvYukJsoxazagGDNTcf5ico0mIZDSRM4o0/PlpgWEtA7R+ADIeaLIA0QbZ6B8FYLe9SXWZd5iYbXkW1+C2JgMTXzj/BbkuJ65Xc45DM7DimjrvG1MHodi1J9BYWQH6J8NTcIQSdQQaLHqMqdspleHxpFEtyye7rL3I+o/X58FXaXfD0y7SWYfEE7QJPgpR3mSpCsnOKboOivA9RnpaO6tjs8IvvqbVkheKSQZUpUUQu6+NiBwWvBiAKs/okyTu2WC1KA/r19Gp7WPXwas/YnePI7Dtz8bFiIGywkw/s4BA9kZnM7DPIj27+vxmpJ5TmWx24q2o6ATUSYjJ9QYhBlmuRzwKKJbbWrwqtiYpaH4tkApOHwWKplzuXD4woqL15T/B8V/ZMU7YhPEL16Ig162fRzS8K6EAE9wiZzM0cwJpjO8s7uZF6sVg6b/uZrrA1J++qMa0siwXF6CYjUCxbjA62Y3sDPUrB8tF8Do+Wzc2pIbUEu17dV1wOfToE2VQVms4q2DlUUbJTILBfK2rqx0snIoFzD0AYCXHd85EdZmmGQF9QGRmAGbmza8O34hcqqDszEbaEcpX3F/UYfXdTbFTvltvlM3ijmganFB/GkHZoNl5SsE2qM7UGenhmIZD6aDau63bznampE3CIWAI2AkPcFDUSWjzMqy6s2n1bqJznavkd6C1BHg+gp2v/gPUSYyHXmFYfAY6bjmFNGoJuFg3NixCYgek4e2sd3/lCWUNQR5t9UQ1gF9bYd1Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(7696005)(82960400001)(8936002)(4326008)(186003)(9686003)(38070700005)(86362001)(53546011)(6506007)(122000001)(2906002)(26005)(966005)(8676002)(52536014)(76116006)(66946007)(64756008)(316002)(508600001)(110136005)(66476007)(55016003)(66446008)(66556008)(54906003)(83380400001)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjZPLzd5Z0xhbVg4T0hvNEFIUTJuMjRyS0YxK2lJM3pFZi9YSGRXd01VeXhG?=
 =?utf-8?B?K1Fpc0VsNkxxTjdoWlg5ZWpPeFcydzl4Y211aHI2cktSLzRtT1dvM0ViNW5j?=
 =?utf-8?B?bnVSbjI4K1ExTmNPVnJaM3pqZVJ5SHN1RlM4VjYzNDZWbkVLWUpMTXlSZ0Nq?=
 =?utf-8?B?M3RhQk9QeWFkVUFyS2VJSXlrMUxGNStGNFVFN2NyZXU5U2s5RUMweFY0bmtT?=
 =?utf-8?B?Qk9Kem05T2V2bjhKamdoVUdHZGpLY3lxYzJSczB1ei9NYm01OVZNVXRncHRT?=
 =?utf-8?B?SXgwMFU2OFcyQ3JrSDErS1BwaGNxTytPV2xBUVdmbjduck5JVVlMT0c5WkpH?=
 =?utf-8?B?U2xJUEtmd3I2RHdzRE1iNXdMZ2I4ek10d2xNcUpJNFZGanJIR1h0bEFwTU16?=
 =?utf-8?B?ZlZxd0NtZWo1b2cybGVpOVgwWldzYWYvUUw0OEQ3Z3UzTmI1d2VrQjZsek9x?=
 =?utf-8?B?YVhmZERXUXBiTjlXNmNHRDl0aWJzY3BHRFNIQzJYeGFDaW1OOW1uL1dvZS80?=
 =?utf-8?B?VGRvUDczcHRGSnA4OXpFcWVhcmJPeERYTTFJNzR6N2hzTkx5d21SN1V0NGk3?=
 =?utf-8?B?Q1dqZ1Foa1Fta2Eyd1RwZ2Z1S0FqUjNGWE5jaXRsQjU5citra2Izc3d5SmxL?=
 =?utf-8?B?cUZGVU9sTk5zNWdnempRSG5EZGJkbGdGQjlpUG5xSDgrTHhWODNNU2tMNGlu?=
 =?utf-8?B?d1V4bVJxUjJGYVJjeUU0WWJ6a3NHV3pCWkNDTEFxUjJDZzBCKzBpZWxQU3Uy?=
 =?utf-8?B?NFZpUVFCSWRpMTJ0YUdKWUFTRzJWclBhZzNQa2JrZTFjT3R6WTVQV1YzSHpI?=
 =?utf-8?B?MkV3Sm85SjlqY3l1WlV6SVJrMjBGdlVod0tIbnlyTWpvUU8xelpJT1FLSGpo?=
 =?utf-8?B?cGo5YlhuZG1ERmtITE9pbU1SREdEQkg5WldqLzQzaFNvSzJjZFA2SWVhb2VT?=
 =?utf-8?B?Mms0Sld4TWhjajl3Q1hteXFZLzNodWlVWGZNeVQ0OGUvVi9remRUbXRVT3dj?=
 =?utf-8?B?emxQUnlSeHA5bHVtOW9CMmY4TWRHenlTWktDTEJ5TkpGd2pKZHIzT1NKU0xX?=
 =?utf-8?B?bzRtUlgrTXFyVzBoU0hsLzdjSldpN0dqb2REZFVyLzVUQXdvbjI5QnBva0p1?=
 =?utf-8?B?UStVdXQyZ3U3QU9yL0hkR2NGcUVScmdiY3RpZkVBaXgwU29TUkU5RWhZbGhl?=
 =?utf-8?B?M3JCN0NhbW9tenY3elVkNU5ZWjZSZXYxcVltTmN3anBjREgxTHRXSlh4M3lI?=
 =?utf-8?B?SXNvZ0dxNGRZYk9nWHBkN0cwVzBudWF4bUtzckFLaDJ4cjBFL3poQjZ5anhT?=
 =?utf-8?B?RXFPV0YxRTcyb21BaUxQOHllb1NDK3B6ZGo5QWRQcXBpZWNoeGdNRVVKQVd3?=
 =?utf-8?B?MFhYNlRKS1hkTnpuTFZaSFVvam94QXE4djkwQ3NrTnRnWTRyY0dkL1RvQy9a?=
 =?utf-8?B?bUwvYlpkQXNZRnE5MmMxME1laFVxQXNXQTFmYXBxL1Y4OFN2VERLVzN0Ri9n?=
 =?utf-8?B?eUJZaU9sVnJjK29XT1hhRTlqVktxSUZvaGpXdFNGRmgwcDFDa0JtaERVdXRE?=
 =?utf-8?B?MFdkZ3lrV0JaampXNzJpTVBBamZ4UGJ3R1JneThKa3kxeG1QcFdGRW4za1Bm?=
 =?utf-8?B?TVZGSCt3L3ljZjRiVUZCUENURndPTjQrSzdPZU1zSk8zemhUM2FsRnVFcjN2?=
 =?utf-8?B?cFlKLzZsbTIxUk5aRzVWd2U1c3V5aFZIcGwxTWFCVWt0TFRQR2tEci82ZThj?=
 =?utf-8?B?OEg4K0dIMm8zZUduaUE0N29xNVJhNFZmR1ZWMHhTZ0JKdE5hbityZ1hEZm55?=
 =?utf-8?B?WmJhblJWc1JnV1h5aUkvN2FpOGFLdUR3UmVla0sxNUVpZEUwbmF6M0tqRmlJ?=
 =?utf-8?B?c3hycytnT0RhSmMrSWcwUlQxTzRMTHkwd2xWMTc1UFpFTHJFd2lRdFVuSXN3?=
 =?utf-8?B?VWxOUHJsRWhUYk5BeEFGT2p2L1YwSmdrUzltY3VhOGtzWkNPRTY0SkowUHho?=
 =?utf-8?B?a0JKajVIdjFObzk5NHpsYlJIODcrTTNEWXhyclpaVHUvZExyWUdXb0pFWXpp?=
 =?utf-8?B?NGk0N21xS09NV3Rad0x3Q2JvVDRPeXR2MERXUWhsVThDUmo5YTd4cWo0VDhC?=
 =?utf-8?B?RFZWS3EyUzdzNzBaWmR1MVF4YjBhdlJzT3FMZTVwTGtGQmw5b0pHYzdkR3lh?=
 =?utf-8?B?TE9vMzdsTHlhRDdqQWFteGFpbHk2RzVCVlJDOVdFQnNXVU9zOTFBaWhVWUMr?=
 =?utf-8?B?Nll3L0xaRjByTTBrSnN4QU5TK0QxYlFzZWcwUUJRTkFKQkYrdjVEZk8ydmFY?=
 =?utf-8?B?Q1o0VDZnZEdZRDhyMFZsLy9ZNmFFL0swaW5hVHcwVlNHUFdiN2lLUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f709803-7262-44b3-bc50-08da121ac8e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 06:59:07.4645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Evl36VMWe1GleSBF2bNl2gXIKX6lZsSzAN50jUQ5Uuab0f1lZlA/uu7TheqU8R95bfmQHm0nta8nMPEL/r881A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE3LCAyMDIyIDg6NDIgQU0NCj4g
VG86IFpoYW5nLCBUaWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IFdlaWdodCwgUnVz
c2VsbCBIDQo+IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT47IHRyaXhAcmVkaGF0LmNvbTsg
bWRmQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBmcGdhQHZnZXIua2VybmVsLm9yZzsgZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmcNCj4gQ2M6IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsg
TWF0dGhldyBHZXJsYWNoDQo+IDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tPg0KPiBT
dWJqZWN0OiBSRTogW1BBVENIIHYxXSB1aW86IGRmbDogYWRkIEhTU0kgZmVhdHVyZSBpZA0KPiAN
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBXdSwgSGFvIDxo
YW8ud3VAaW50ZWwuY29tPg0KPiA+ID4gU2VudDogVHVlc2RheSwgTWFyY2ggMTUsIDIwMjIgNToz
MiBQTQ0KPiA+ID4gVG86IFpoYW5nLCBUaWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47
IFdlaWdodCwgUnVzc2VsbCBIDQo+ID4gPiA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+OyB0
cml4QHJlZGhhdC5jb207IG1kZkBrZXJuZWwub3JnOw0KPiA+ID4gbGludXgtIGZwZ2FAdmdlci5r
ZXJuZWwub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPiA+ID4gQ2M6IFh1LCBZaWx1
biA8eWlsdW4ueHVAaW50ZWwuY29tPjsgTWF0dGhldyBHZXJsYWNoDQo+ID4gPiA8bWF0dGhldy5n
ZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjFdIHVp
bzogZGZsOiBhZGQgSFNTSSBmZWF0dXJlIGlkDQo+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogV3UsIEhhbyA8aGFvLnd1QGludGVsLmNv
bT4NCj4gPiA+ID4gPiBTZW50OiBNb25kYXksIE1hcmNoIDE0LCAyMDIyIDExOjA5IEFNDQo+ID4g
PiA+ID4gVG86IFpoYW5nLCBUaWFuZmVpIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT47IFdlaWdo
dCwgUnVzc2VsbCBIDQo+ID4gPiA+ID4gPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsgdHJp
eEByZWRoYXQuY29tOyBtZGZAa2VybmVsLm9yZzsNCj4gPiA+ID4gPiBsaW51eC0gZnBnYUB2Z2Vy
Lmtlcm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gPiA+ID4gQ2M6IFh1
LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29tPjsgTWF0dGhldyBHZXJsYWNoDQo+ID4gPiA+ID4g
PG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gU3ViamVjdDogUkU6
IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZlYXR1cmUgaWQNCj4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gPiBGcm9t
OiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPiBTZW50OiBGcmlkYXks
IE1hcmNoIDExLCAyMDIyIDEwOjQ3IEFNDQo+ID4gPiA+ID4gPiA+IFRvOiBXZWlnaHQsIFJ1c3Nl
bGwgSCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+OyBaaGFuZywNCj4gPiA+ID4gPiA+ID4g
VGlhbmZlaSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyB0cml4QHJlZGhhdC5jb207DQo+ID4g
PiA+ID4gPiA+IG1kZkBrZXJuZWwub3JnOyBsaW51eC0gZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+
ID4gPiA+ID4gPiA+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gPiA+ID4gPiA+IENj
OiBYdSwgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT47IE1hdHRoZXcgR2VybGFjaA0KPiA+ID4g
PiA+ID4gPiA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPiA+ID4g
U3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlvOiBkZmw6IGFkZCBIU1NJIGZlYXR1cmUgaWQNCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBPbiAzLzcvMjIgMjI6NDMsIFRpYW5mZWkgWmhh
bmcgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBNYXR0aGV3IEdlcmxhY2ggPG1hdHRo
ZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+ID4gQWRkIHRoZSBmZWF0dXJlIGlkIG9mIHRoZSBPRlMgSGlnaCBTcGVlZCBTZXJpYWwN
Cj4gPiA+ID4gPiA+ID4gPiA+IEludGVyZmFjZSBzdWJzeXN0ZW0gdG8gdGFibGUgb2YgaWRzIHN1
cHBvcnRlZCBieSB0aGUgdWlvX2RmbA0KPiBkcml2ZXIuDQo+ID4gPiA+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGhldyBHZXJsYWNoDQo+ID4gPiA+ID4g
PiA+ID4gPiA8bWF0dGhldy5nZXJsYWNoQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkgWmhhbmcgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29t
Pg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gUmV2aWV3ZWQtYnk6IFJ1c3MgV2Vp
Z2h0IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiA+IC0tLQ0K
PiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdWlvL3Vpb19kZmwuYyB8IDIgKysNCj4gPiA+ID4g
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdWlvL3Vpb19kZmwu
Yw0KPiA+ID4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMgaW5kZXgNCj4gPiA+
ID4gPiA+ID4gPiA+IDg5YzBmYzdiMGNiYy4uNjYwZTFkMGJmNmI5IDEwMDY0NA0KPiA+ID4gPiA+
ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91aW8vdWlvX2RmbC5jDQo+ID4gPiA+ID4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3Vpby91aW9fZGZsLmMNCj4gPiA+ID4gPiA+ID4gPiA+IEBAIC00NSw5ICs0
NSwxMSBAQCBzdGF0aWMgaW50IHVpb19kZmxfcHJvYmUoc3RydWN0DQo+ID4gPiA+ID4gPiA+ID4g
PiBkZmxfZGV2aWNlDQo+ID4gPiA+ID4gPiA+ID4gPiAqZGRldikgfQ0KPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+ICAjZGVmaW5lIEZNRV9GRUFUVVJFX0lEX0VUSF9HUk9VUAkw
eDEwDQo+ID4gPiA+ID4gPiA+ID4gPiArI2RlZmluZSBGTUVfRkVBVFVSRV9JRF9PRlNfSFNTSQkJ
MHgxNQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBXaGVyZSBpcyB0aGUgIk9GUyIgY29t
aW5nIGZyb20/IGlzIGl0IGZvciBhbGwgT0ZTIGRldmljZSBvcg0KPiA+ID4gPiA+ID4gPiBhIHNw
ZWNpZmljDQo+ID4gPiBjYXJkPw0KPiA+ID4gPiA+ID4gPiBBbnl3YXksIGNvdWxkIHdlIGhhdmUg
YSBtYXRjaGVkIG5hbWUgcGVyIHB1YmxpYyB0YWJsZT8NCj4gPiA+ID4gPiA+ID4gaHR0cHM6Ly9n
aXRodWIuY29tL09QQUUvbGludXgtZGZsLWZlYXR1cmUtaWQvYmxvYi9tYXN0ZXIvZGZsDQo+ID4g
PiA+ID4gPiA+IC1mZWENCj4gPiA+ID4gPiA+ID4gdHVyZQ0KPiA+ID4gPiA+ID4gPiAtaWRzLnJz
dA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFllcywgSSB0aGluayBhIG1hdGNoZWQgbmFtZSBv
ZiBwdWJsaWMgdGFibGUgd2lsbCBiZSBiZXR0ZXIuDQo+ID4gPiA+ID4gPiBIb3cgYWJvdXQgdGhl
DQo+ID4gIg0KPiA+ID4gPiA+ID4gRk1FX0ZFQVRVUkVfSURfSFNTSSI/DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBOby4gV2UgYWxyZWFkeSBoYXZlIHRoZSBzYW1lIG5hbWUgZm9yIGlkIDB4NiBkZWZp
bmVkIGluDQo+ID4gZHJpdmVycy9mcGdhL2RmbC5oDQo+ID4gPiA+ID4gI2RlZmluZSBGTUVfRkVB
VFVSRV9JRF9IU1NJCQkweDYNCj4gPiA+ID4NCj4gPiA+ID4gSXMgaXQgcG9zc2libGUgY2hhbmdl
IHRoZSAiRk1FX0ZFQVRVUkVfSURfSFNTSSIgdG8gIg0KPiA+ID4gPiBGTUVfRkVBVFVSRV9JRF9M
RUdBQ1lfSFNTSSIsIGFuZCB0aGUgbmV3IG9uZSBpcyAiDQo+ID4gPiA+IEZNRV9GRUFUVVJFX0lE
X0hTU0kiPw0KPiA+ID4NCj4gPiA+IEkgYW0gbm90IHN1cmUgd2hvIG93bnMgdGhlIElEIGFsbG9j
YXRpb24gdGFibGUsIGFuZCB3aHkNCj4gPiA+IDB4NiBpcyBjaGFuZ2VkIHRvICJMZWdhY3kiIEhT
U0kgYnV0IEkgZmVlbCBpdCdzIGJldHRlciB0byBoYXZlIGENCj4gPiA+IHNwZWNpZmljIHByZWZp
eA0KPiA+IGZvcg0KPiA+ID4gdGhpcyBIU1NJIGluc3RlYWQsIEkgaG9wZSB3ZSBkb24ndCBoYXZl
IHRvIGNoYW5nZSB0aGlzIDB4MTUgSFNTSSB0bw0KPiA+ID4gYW5vdGhlciBsZWdhY3kgb25lIHdo
ZW4gc29tZW9uZSBhZGRzIGEgbmV3IEhTU0kuIFRoaXMgaXMgZm9yIEZQR0EsDQo+ID4gPiBldmVy
eWJvZHkgY291bGQgaW1wbGVtZW50IGhpcyBvd24gSFNTSSwgZ2VuZXJpYyBuYW1lIHNob3VsZCBi
ZSBhdm9pZA0KPiA+ID4gd2hlbiBwb3NzaWJsZSwgYW5kIGEgYmV0dGVyIHJ1bGUgd2hlbiBtYW5h
Z2luZyB0aGUgZmVhdHVyZSBJRHMuDQo+ID4NCj4gPiBZZXMsIEkgdGhpbmsgdGhpcyBIU1NJIHdh
cyBkZXNpZ25lZCBmb3IgT0ZTLCB1c2luZyAiT0ZTIiBhcyBwcmVmaXggaXMgYmV0dGVyLg0KPiAN
Cj4gVGhlbiBjaGFuZ2UgdGhlIG5hbWUgaW4NCj4gaHR0cHM6Ly9naXRodWIuY29tL09QQUUvbGlu
dXgtZGZsLWZlYXR1cmUtaWQvYmxvYi9tYXN0ZXIvZGZsLWZlYXR1cmUtaWRzLnJzdA0KPiBhcyB3
ZWxsLg0KDQpUaGFua3MgSGFvJ3MgY29tbWVudCwgaXQgaGFzIGNoYW5nZWQgdG8gIiBPRlMgSFNT
SSBTdWJzeXN0ZW0iIGluIHRoaXMgZ2l0IHJlcG8uDQo=
