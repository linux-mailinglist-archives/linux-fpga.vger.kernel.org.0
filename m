Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664034BDC58
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357260AbiBUMF6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 07:05:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357257AbiBUMF4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 07:05:56 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF1201A7;
        Mon, 21 Feb 2022 04:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645445131; x=1676981131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fgzyMDhAh5TiNRcGuMNbBxd+/pEktAmwUrbd+chuK4g=;
  b=U0HNz2gsE1VMxXp1TGHDSvKBRUi4nnLPANgRQgM86VAmJz3bNtzaW6r9
   UNtqMB7/227TY4SqbsGZlcXXnWJS/O5ol06HX+w9I8iO/0gB2JgVBOP8u
   S6g7Wzzst0Sy1cvMZLgSzs5H28w2NLMs12Kvxtsi8nMC4XMUNhJufKIfm
   i8dG4VHqfX7CvG9l/ekukqBbJYl3/x6JQpD7h8iBbzHTim/CmwJYJXwXD
   wQ+YIZzI5E/5RJhdvMqzpApmCOssnJ0eebsc4Rz/Cis290m2OCK0ntdXm
   k3WRC0I0qkZuVNz+As8dUw7GgR2EF/zMg5Zmt/BcWgMbo7fNlFdiKCt2O
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="312241036"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="312241036"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 04:05:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="590945583"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 04:05:30 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 04:05:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 21 Feb 2022 04:05:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 21 Feb 2022 04:05:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI4yoUyeO5a3bUQDMMjGsyUCHk26ATajtlYwh5jveLkQHQZE9zyIeH4rtSIEHRaYy6Wo9M18m71tv+RbYzW+36657DHcWrxryPDcqk0+7KaBJqbfnUnoZ1owivaGxcGxq5C3X/vALuzZAp280A11bnlJZD0IlGAgSHBr6o50frNS61yCE84UUWFIBL45ZoPUDAtjrfDE48via6l7fA884ktWKuJrtQUqKk0Pb7ehMjXgQmEuKxa/thS130OgLWAYmRBSXpj5zdJmRHBPLyqwlw2XPPnvf4sgtWib7w47W0dPxXqFa7WiHIukOrGri1pStvWO+rW3Newc59c47op+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgzyMDhAh5TiNRcGuMNbBxd+/pEktAmwUrbd+chuK4g=;
 b=AynHgpuWTdQmaqgkZVaQUW7fAToewdie3Ck/6q3UzYqyu/L0C5F2lbndv3n/tSgBZwmjlljA2GZoGlhMKGharkHjb0x4BtM6DBK6W33ibOXPWDCBkKJi7VlVgKF7/fdpjiHxhGdOO5bgDhyTw7AmxfzgwlG0w9lNhew3i5AAlMBltS8RfCRjlHRvKjIqmW2tfm/VkmhizZrvZWhkKI+m7yLBsDD+85XDQtYxK5dqiuDgXLKUlQ3UMfLZriMD/MSW481kr9qVLRMxWd54nSeV0aIjXsqbvTbhqF1fqizcTQprzX5WWOjwDWkoL1oSfUn2mIRAulZd1FKq9lERPzZLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CH2PR11MB4245.namprd11.prod.outlook.com (2603:10b6:610:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 12:05:25 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 12:05:25 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     Tom Rix <trix@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
Thread-Topic: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
Thread-Index: AQHYIZYutGpfsM893k+7OxgKTgvvjqyUsy6AgAQun8CAAIL8gIAEjlhg
Date:   Mon, 21 Feb 2022 12:05:25 +0000
Message-ID: <BN9PR11MB5483C46D41DC8CF5893F1832E33A9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
 <BN9PR11MB54839B6D444DCEB7FD789F33E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <447ce66b-dea7-da2b-6879-e4d37a74ba7d@redhat.com>
In-Reply-To: <447ce66b-dea7-da2b-6879-e4d37a74ba7d@redhat.com>
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
x-ms-office365-filtering-correlation-id: 4c77d044-0b18-4a90-9630-08d9f53271b6
x-ms-traffictypediagnostic: CH2PR11MB4245:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB424598B7E0BD37989B34C377E33A9@CH2PR11MB4245.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyqiflHMHVQvswRwUb5T1kl6gyrD7Vo+NClo+wg55X2/xS3XV3hzJk1wunJHoaRcbrm3DKkUcm0UBdgXiPfFC3t4Kb9IZ+u4AzCppTC50hIDbJfq43S1JvmN4+bYPGUUd+lUP2JVLahZwLoauDCJq7DUT0JgvXigZiqVJ47GGd/C7URsesKEXu+jj9/nRtwnIzPezzI6mbmBsxroeWA/mLygYNu3m/gkyU0IxxYV0yTiUCYagaHLkYNvbdiN6zh/ItNiyP3/lDHYdFILm5LoQR0cLXu6g+P7Tj8obgdYtz03GHC1O0rWOIzDccylM13rj/7DAZwFtjKyJcKGBwDhKaN0hU9NeIadz/w1gDQkO9iIxEqm0P7UkOIw73KzAMD10ZoeiWhPShS9CTOhnbU8fqkrt+SFUpBextCXLlTDgc+yfXCsufXQZtj4DTlnrFOGZxCD5OjkKngncvgfYZaHmQA2H9TeVKejBtfWD9bs5J2VswhbihVP6p5WGqllaiiavkmoYp1E9z4FXZAh4OKIM2AwSKTOlIDZk7gPMecVia7gN8K8VjF5rcPTzo9cBn0GwAn+wLf7D0qErhIwzXMZsh++6AuBhRKg8QZz1Fgfd5a7/OMVAgdiowuPLBl+iUgE1ShIldzgc8ItGIkOV+u6sGiGY5VweenBqylbwblnR9LDdh39+zf8FrfANCP9nt+toC2wS0OKRQoyus6SAQdc13r4xdZWjEGqNYWKhGb0CSB2rESXiKbdzCNuw8zlNUt+QP/DdrpuskkKt1ItWCG4r84kHSS0KcksCxn7/t/MDJbp2VssbfrY4zmO+oqzMCISoeM87CbLaQXc00PisIbwug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(7696005)(71200400001)(508600001)(55016003)(6506007)(966005)(38070700005)(53546011)(9686003)(2906002)(38100700002)(4326008)(66446008)(5660300002)(186003)(110136005)(8676002)(26005)(52536014)(8936002)(316002)(122000001)(86362001)(82960400001)(76116006)(83380400001)(66556008)(66476007)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkVYV1d4eHZkTU92bVJySzl1NjZqenR6WG5wMFVJcjI0MVczbkpHTHRMR2ZY?=
 =?utf-8?B?ZCs1YVNOdDZ3YVpTKzZ3UWp0WXdRT3UydCtJeWJsb2xBc2NoMUhseC9CT2Jr?=
 =?utf-8?B?ZXBzdDJac0dvUzc2Ykkxc0VPZ21Fc3ZTTGtZbGRKNUJLTEJCT1FwK09tR3hD?=
 =?utf-8?B?V1kvekJsTlM1a1l2eUhiNk9oM1FoZ0ZsV3B6ZFNJeTNlMDlacEJsenBpeGlY?=
 =?utf-8?B?MEsrNzdpTmt2cENyQklBbno0ZktjM1IrbW0yMTBDWWZqQjdRdWZyTzBsaDJU?=
 =?utf-8?B?T2JrczhhNjkxd1duNTNDc2x4OFNhMDRicUYvQ2hwYlNMdWVRdFNSbVdPSWI3?=
 =?utf-8?B?RXBOTTZvUEw4STRFZGJKMjdvRGlpbHl1eWlVSlN4NXhORkgzNmN4dWthS3M3?=
 =?utf-8?B?U0VnOWhMREpsdTlhenc2SlBZZVhOMWg5M2RMaTBTamJha1d6M0FXMktCdG9X?=
 =?utf-8?B?aE1XV3FZTmdVZXFEbjE4V2wrQkNXRkpybUEvM2dFcjNaZXdhSHNMeG1QWHUz?=
 =?utf-8?B?cjJzZ2tpQXFwZjRIUWxzckJWNnErakorQkVmdnYxMk1tcGgwdjhFSHJoMWhB?=
 =?utf-8?B?Z2UzTkdDc3NQcndaN1dRdDhlQm0vZkQ2VGV0TjNyTzB4a3ZDSjhFZXpjYVlw?=
 =?utf-8?B?NnV2NkxXdU40cUNjZytKQU5CaklyRmVaZllRbDI2MEdyYkFpNnoycVRPY3pz?=
 =?utf-8?B?NkRJS3NtUEM4SmdLa3hDeU9wMHJrTHd5V2VnSVpkK0JXRjFEakNpaVJWaGZS?=
 =?utf-8?B?RmNwbzQwZ2MyNm9FWncrQWc5ZDNITW9mT3VIRTJFQlhrQ1ZaM1JtaHpzUVRo?=
 =?utf-8?B?OXF5UDdubTM0NUd5dXUzODdoazgxWlBHTE1wK2loaTFjSkFtUDlKMVVqSWJZ?=
 =?utf-8?B?WGJ0Lzd0NTdpeXR1NnFnVSt4bnNKa2NMUWFkL0hPKzBHbEpPVkJDQU9uM2M3?=
 =?utf-8?B?MFU3bWp2TlZ5RmFEYThWRWZaSHgwYnFmd2k0LzZNNDd3c25nMmcrMEQ0YnBT?=
 =?utf-8?B?ZGorTUY3cHI1UloySmRqdG1sd1RaK1JzaVJXTGYybEovaGptd203amZJVmY1?=
 =?utf-8?B?ZnB1Y201RXlVNU5lSU12ejVScGhERHBFaWVKWGFKNnR6WEczUDl5Y0FxUVY1?=
 =?utf-8?B?cmtTODFWczd6T0VIYkRGWGppemdScnZjdENBeGNIRGhkWGVwQ3ZYNDFiN0RP?=
 =?utf-8?B?aS9abDd6UlF5Vy8xWGs5aW5Ha05zZmhpaW1qNDRQTGJZM2ZZS1pNQmpDNmJp?=
 =?utf-8?B?NlNGSnBSWjhpQmxrSmdUNjVwYWFhakU0WHh5TUg3UE9GeFRXYzF5U01wbXc3?=
 =?utf-8?B?QnpSVGVKS3A3aUZRZk9YNVF1V3pZaTQvVzdkVVdCbkthTllQUDBBTWFva0Zh?=
 =?utf-8?B?ZUxnczVzaU9vT1RxTDlac3RXMi9uUDMvYXF3ZzZod25rdExmWFcwNjFhbk5M?=
 =?utf-8?B?R3BVMFBkUWd2b2EyUzVRamtFYUh5QUE5QmsyYXlQK2NYaTZUamVzSGdHY21W?=
 =?utf-8?B?RDgwWUpkUUZtNVowWkYyaXhEOHlWUXo0bHdZaWVtNTc3R2FzRjM2QW9HRVY3?=
 =?utf-8?B?WS9ObE50ZkcybWpiejJaY1h4L1pocDlZYXU1ekFOamQva1czaUZFZDBmaDFG?=
 =?utf-8?B?VERmd0t1T3FlQno3dmdhY0dPNmdPL3FRUGhyTGV6MU9IQktSR3oyNDlKZHBy?=
 =?utf-8?B?MTN2eUh5RGMrM2ZML1RiZlZEQ1hOblVCZktaU3RMUmx5eHRBcGhPNUtyRnl3?=
 =?utf-8?B?d1NabWxzN09SalEybHhMNHpUNFJ0TXBmZmp0VkJEd2ZNYU9oV21wYmZKTjBX?=
 =?utf-8?B?ZW0rUlZvWkRmTXQ2OWFiVGliMW1NNkRzNTZJcjdFbExkOHZGbDdKQ254cnht?=
 =?utf-8?B?eXp1QlU5UmlFRGVTbkd2YU5vM3o2TFNzRFFmanloV3hQWkV5NUROakFZbDJZ?=
 =?utf-8?B?Um1iaEswNUZrc3JJTlFNUUhIc1d1MkpDMVBVcXNLakpTRUhIZTdkL1ZRV2Ny?=
 =?utf-8?B?SjVCbTBLK1lDdUhkMitLblZ5TzlWSldxQnI2UzU0SlB4d01CeHU0eDFCd3l2?=
 =?utf-8?B?OTkwUlhJTUcyWXN4a2kyLzVBdFN3VnJtSWg3UXhnWmZzMDB6TXc0cnl3NzRO?=
 =?utf-8?B?NUdqbE12QStMdEVqOGNEcGRHVElhMHlSKzBWMTRhM2F4V0lNNGJNcTM3eGY4?=
 =?utf-8?Q?rJDc/pNKBoJzkYZXlSjqAqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c77d044-0b18-4a90-9630-08d9f53271b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 12:05:25.3816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41BKgAmT9eLeVb/eyyKK0Hn2IMcwiw/bCA9ew0ynJBiyyje6H3RNeJVolkFmxVK/Woy4803+wS7r/XWS1v3Phg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDE4LCAyMDIyIDEwOjMwIFBNDQo+
IFRvOiBaaGFuZywgVGlhbmZlaSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXdSwgSGFvIDxo
YW8ud3VAaW50ZWwuY29tPjsNCj4gbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWlsdW4ueHVA
aW50ZWwuY29tPjsgbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWRvY0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGNvcmJldEBs
d24ubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi83XSBmcGdhOiBkZmw6IGNoZWNrIGZl
YXR1cmUgdHlwZSBiZWZvcmUgcGFyc2UgaXJxIGluZm8NCj4gDQo+IA0KPiBPbiAyLzE3LzIyIDEw
OjUzIFBNLCBaaGFuZywgVGlhbmZlaSB3cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+ID4+IFNl
bnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDE1LCAyMDIyIDEwOjQ5IFBNDQo+ID4+IFRvOiBaaGFuZywg
VGlhbmZlaSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyBXdSwgSGFvDQo+ID4+IDxoYW8ud3VA
aW50ZWwuY29tPjsgbWRmQGtlcm5lbC5vcmc7IFh1LCBZaWx1biA8eWlsdW4ueHVAaW50ZWwuY29t
PjsNCj4gPj4gbGludXgtZnBnYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IGNvcmJl
dEBsd24ubmV0DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi83XSBmcGdhOiBkZmw6IGNo
ZWNrIGZlYXR1cmUgdHlwZSBiZWZvcmUNCj4gPj4gcGFyc2UgaXJxIGluZm8NCj4gPj4NCj4gPj4N
Cj4gPj4gT24gMi8xNC8yMiAzOjI2IEFNLCBUaWFuZmVpIHpoYW5nIHdyb3RlOg0KPiA+Pj4gRnJv
bTogVGlhbmZlaSBaaGFuZyA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+DQo+ID4+Pg0KPiA+Pj4g
VGhlIGZlYXR1cmUgSUQgb2YgIlBvcnQgVXNlciBJbnRlcnJ1cHQiIGFuZCB0aGUgIlBNQ0kgU3Vi
c3lzdGVtIiBhcmUNCj4gPj4+IGlkZW50aWNhbCwgMHgxMiwgYnV0IG9uZSBpcyBmb3IgRk1FLCBv
dGhlciBpcyBmb3IgUG9ydC4gSXQgc2hvdWxkDQo+ID4+PiBjaGVjayB0aGUgZmVhdHVyZSB0eXBl
IFdoaWxlIHBhcnNpbmcgdGhlIGlycSBpbmZvIGluDQo+ID4+PiBwYXJzZV9mZWF0dXJlX2lycXMo
KS4NCj4gPj4gVGhpcyBzZWVtcyBsaWtlIGEgYnVnIGZpeCBhbmQgbm90IHBhcnQgb2YgaW9mcyBm
ZWF0dXJlLg0KPiA+Pg0KPiA+PiBTcGxpdCB0aGlzIG91dCBvZiB0aGUgcGF0Y2hzZXQuDQo+IA0K
PiA/DQoNCkkgYWdyZWUsIEkgd2lsbCBzZW5kIHRoaXMgcGF0Y2ggYXMgYSBidWcgZml4Lg0KDQo+
IA0KPiA+Pg0KPiA+PiBUaGlzIGlzIGEgd29ya2Fyb3VuZCBhIGhhcmR3YXJlIHByb2JsZW0sIHRo
ZXJlIHNob3VsZCBiZSBzb21lDQo+ID4+IGNvbW1lbnRzIHRvIHRoZSBlZmZlY3QgdGhhdCB5b3Ug
Y2FuJ3QgdHJ1c3QgX3RoaXNfIG9yIF90aGF0XyBmZWF0dXJlDQo+ID4+IGlkIGFuZCBzb21lIHNw
ZWNpYWwgaGFuZGxpbmcgZWFybGllci4NCj4gPj4NCj4gPj4gVGhlIGFtYmlndWl0eSBvZiBmZWF0
dXJlIGlkIGlzIGEgcHJvYmxlbSwgYW5kIHRoaXMgc29ydCBvZiBidWcgd2lsbCBoYXBwZW4NCj4g
YWdhaW4uDQo+ID4+DQo+ID4+IFdoYXQgY2FuIGJlIGRvbmUgdG8gcHJldmVudCB0aGlzIGluIHRo
ZSBmdXR1cmUgPw0KPiA+IFRoaXMgcGF0Y2ggaXMgbm90IHdvcmthcm91bmQsIHRoaXMgaXMgYSBi
dWcgZml4IGZvciBERkwgZHJpdmVyLg0KPiA+IFRoZSByb290IGNhdXNlIGlzIHRoYXQgRExGIGRy
aXZlciBtaXNzIGNoZWNrIHRoZSBmZWF0dXJlIHR5cGUgd2hpbGUNCj4gPiBwYXJzaW5nIHRoZSBp
bnRlcnJ1cHQgaW5mb3JtYXRpb24sIGJlY2F1c2Ugc29tZSBGZWF0dXJlIElEcyBhcmUgaWRlbnRp
Y2FsDQo+IGJldHdlZW4gRk1FIGFuZCBQb3J0LCBsaWtlIFBNQ0kgaW4gRk1FIGFuZCAiUG9ydCBV
c2VyIEludGVycnVwdCINCj4gPiBpbiBQb3J0Lg0KPiA+IFRoZSBkZWZpbml0aW9uIG9mIEZlYXR1
cmUgSUQgaXMgaGVyZToNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vT1BBRS9saW51eC1kZmwtZmVh
dHVyZS1pZC9ibG9iL21hc3Rlci9kZmwtZmVhdHVyZS1pDQo+ID4gZHMucnN0DQo+IEhlbHBmdWwg
YnV0IGhpZGRlbi7CoCBBdCBsZWFzdCBhIGxpbmsgdG8gdGhpcyBzaG91bGQgYmUgYWRkZWQgdG8N
Cj4gRG9jdW1lbnRhdGlvbi9mcGdhL2RmbC5yc3QuDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBUaWFu
ZmVpIFpoYW5nIDx0aWFuZmVpLnpoYW5nQGludGVsLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAg
ZHJpdmVycy9mcGdhL2RmbC5jIHwgMTEgKysrKysrKysrKysNCj4gPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZnBnYS9kZmwuYyBiL2RyaXZlcnMvZnBnYS9kZmwuYyBpbmRleA0KPiA+Pj4gNTk5YmIyMWQ4NmFm
Li4yNmY4Y2Y4OTA3MDAgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2ZwZ2EvZGZsLmMNCj4g
Pj4+ICsrKyBiL2RyaXZlcnMvZnBnYS9kZmwuYw0KPiA+Pj4gQEAgLTk0MCw5ICs5NDAsMTQgQEAg
c3RhdGljIGludCBwYXJzZV9mZWF0dXJlX2lycXMoc3RydWN0DQo+ID4+IGJ1aWxkX2ZlYXR1cmVf
ZGV2c19pbmZvICpiaW5mbywNCj4gPj4+ICAgIHsNCj4gPj4+ICAgIAl2b2lkIF9faW9tZW0gKmJh
c2UgPSBiaW5mby0+aW9hZGRyICsgb2ZzdDsNCj4gPj4+ICAgIAl1bnNpZ25lZCBpbnQgaSwgaWJh
c2UsIGluciA9IDA7DQo+ID4+PiArCWVudW0gZGZsX2lkX3R5cGUgdHlwZTsNCj4gPj4+ICAgIAlp
bnQgdmlycTsNCj4gPj4+ICAgIAl1NjQgdjsNCj4gPj4+DQo+ID4+PiArCXR5cGUgPSBmZWF0dXJl
X2Rldl9pZF90eXBlKGJpbmZvLT5mZWF0dXJlX2Rldik7DQo+ID4+PiArCWlmICh0eXBlID49IERG
TF9JRF9NQVgpDQo+ID4+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPj4+ICsNCj4gPj4+ICAgIAkv
Kg0KPiA+Pj4gICAgCSAqIElkZWFsbHkgREZMIGZyYW1ld29yayBzaG91bGQgb25seSByZWFkIGlu
Zm8gZnJvbSBERkwgaGVhZGVyLCBidXQNCj4gPj4+ICAgIAkgKiBjdXJyZW50IHZlcnNpb24gREZM
IG9ubHkgcHJvdmlkZXMgbW1pbyByZXNvdXJjZXMgaW5mb3JtYXRpb24NCj4gPj4+IGZvciBAQCAt
OTU5LDE2ICs5NjQsMjIgQEAgc3RhdGljIGludCBwYXJzZV9mZWF0dXJlX2lycXMoc3RydWN0DQo+
ID4+IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPj4+ICAgIAkgKi8NCj4gPj4+
ICAgIAlzd2l0Y2ggKGZpZCkgew0KPiA+Pj4gICAgCWNhc2UgUE9SVF9GRUFUVVJFX0lEX1VJTlQ6
DQo+ID4+PiArCQlpZiAodHlwZSAhPSBQT1JUX0lEKQ0KPiA+Pj4gKwkJCWJyZWFrOw0KPiA+PiBJ
bnN0ZWFkIG9mIGVtYmVkZGluZyBhIGJyZWFrIGluIHRoZSBzd2l0Y2gsIGJyZWFrIHRoZSBzd2l0
Y2ggaW50byBmbWUNCj4gPj4gc3dpdGNoIGFuZCBwb3J0IHN3aXRjaA0KPiA+Pg0KPiA+PiBpZiAo
dHlwZSA9PSBQT1JUX0lEKQ0KPiA+Pg0KPiA+PiAgIMKgIHBvcnQtc3dpdGNoDQo+ID4+DQo+ID4+
IGVsc2UgaWYgKHR5cGUgPT0gRk1FX0lEDQo+ID4+DQo+ID4+ICAgwqAgZm1lLXN3aXRjaA0KPiA+
IFlvdXIgc3VnZ2VzdGlvbiBpcyBsb29rcyBnb29kICBmb3IgbWUsIEkgd2lsbCBjaGFuZ2Ugb24g
bmV4dCB2ZXJzaW9uLg0KPiA+DQo+ID4+IFRvbQ0KPiA+Pg0KPiA+Pj4gICAgCQl2ID0gcmVhZHEo
YmFzZSArIFBPUlRfVUlOVF9DQVApOw0KPiA+Pj4gICAgCQlpYmFzZSA9IEZJRUxEX0dFVChQT1JU
X1VJTlRfQ0FQX0ZTVF9WRUNULCB2KTsNCj4gPj4+ICAgIAkJaW5yID0gRklFTERfR0VUKFBPUlRf
VUlOVF9DQVBfSU5UX05VTSwgdik7DQo+ID4+PiAgICAJCWJyZWFrOw0KPiA+Pj4gICAgCWNhc2Ug
UE9SVF9GRUFUVVJFX0lEX0VSUk9SOg0KPiA+Pj4gKwkJaWYgKHR5cGUgIT0gUE9SVF9JRCkNCj4g
Pj4+ICsJCQlicmVhazsNCj4gPj4+ICAgIAkJdiA9IHJlYWRxKGJhc2UgKyBQT1JUX0VSUk9SX0NB
UCk7DQo+ID4+PiAgICAJCWliYXNlID0gRklFTERfR0VUKFBPUlRfRVJST1JfQ0FQX0lOVF9WRUNU
LCB2KTsNCj4gPj4+ICAgIAkJaW5yID0gRklFTERfR0VUKFBPUlRfRVJST1JfQ0FQX1NVUFBfSU5U
LCB2KTsNCj4gPj4+ICAgIAkJYnJlYWs7DQo+ID4+PiAgICAJY2FzZSBGTUVfRkVBVFVSRV9JRF9H
TE9CQUxfRVJSOg0KPiA+Pj4gKwkJaWYgKHR5cGUgIT0gRk1FX0lEKQ0KPiA+Pj4gKwkJCWJyZWFr
Ow0KPiA+Pj4gICAgCQl2ID0gcmVhZHEoYmFzZSArIEZNRV9FUlJPUl9DQVApOw0KPiA+Pj4gICAg
CQlpYmFzZSA9IEZJRUxEX0dFVChGTUVfRVJST1JfQ0FQX0lOVF9WRUNULCB2KTsNCj4gPj4+ICAg
IAkJaW5yID0gRklFTERfR0VUKEZNRV9FUlJPUl9DQVBfU1VQUF9JTlQsIHYpOw0KDQo=
