Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1B4BB2BA
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Feb 2022 07:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiBRGx2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Feb 2022 01:53:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiBRGx0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Feb 2022 01:53:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2564EC;
        Thu, 17 Feb 2022 22:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645167190; x=1676703190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WDBDAQSReevxeW1z9+EKMzeCLaqRpJnU9+7N1UD+C3I=;
  b=SVVRy25WVT4uTTVxFKrajB+wizSnGqAvVbIcX1rKmzbwdGVvn1VThFnm
   cxvzRoJTIy+JseehCPfS/tPv8OQhCFGjOhvM7JmqJt2fs2mY7xZjG3k1k
   FVFkHdNEKTY1Vtec4dsdiPsTe1P2wAiq4673Ff/yhNsZWbXwyGkOZiNFA
   GPzbv77FuBwTh1Wva3najloWCdB9kdiXmkTMILsmLHD7LwXTJs1sOb9T7
   sR7L7Hr2UD7iAFSFUqF9pH6GwggoNx1+4YmvWvZSbDa+4UUiH4qioqw4a
   +uoYn23Ua7TRtvQHaR/5diLZ4D0GEqQxHSWVfBEWOezK5rShiTjKs69Cg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248661821"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="248661821"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="637647018"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 22:53:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 22:53:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 22:53:09 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 22:53:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kk4TV0JCBGrmd6RQjZJ99ccFIDehhw373HgsoPr44KEry8a3jvKoLLr42vNDSm1Yn9PrYkSCxrSqmH739SKeXHg3sQIzeWOPRCk/4RT31Njz9RRMK0VsGJ694+d0PMosErumTNiKEp79qDsdrqBgCGOdiyEih4mYoE6+laftSniqIBwHcu4u2OYUrUl9fXbMbqXYoAu+FSbidjt4CpW3oBSJT+UmSaGm3JmMtGFC83/bMSpkqhJgnWHWhOPRwZNq73uq52qSBtz8o3tHBmYYvDp/G6/6GiCyLSWNoOWR+GPw8dwXdzi7a7zUKzmV5oEOUlHmfY7wACdunu2GMDK0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDBDAQSReevxeW1z9+EKMzeCLaqRpJnU9+7N1UD+C3I=;
 b=D+iCu514PaDGPHn8AJKAulTnD3sUfEyF5y5e7daW1/zawitPBhH+n8azOzkRvVTvIvd6EY4zlGTqjAULCMtv44CligzzpvrpUiLtZTX372AeY1Y0Go2rDr5K5RfK4By2pSLq36/R+Dx094VzMD8e85cyhitTnUCQM5YewcteG3atrmJKyzpH1mWmM2auR0A2zPBJRQferEvbymNeZoLZNBMEMbbEdbvsld0sCYo3pENNASFXSqOkCsX0MGVjMTtN9Mmc7Hfs7eBX25JjccV1EO5z3yJjACqNWmE/mbAGD241MdF9/HYRtjB6pBixM6GAOsirkN+jQYHD71fujV8nDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BN8PR11MB3604.namprd11.prod.outlook.com (2603:10b6:408:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 06:53:06 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.017; Fri, 18 Feb 2022
 06:53:06 +0000
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
Thread-Index: AQHYIZYutGpfsM893k+7OxgKTgvvjqyUsy6AgAQun8A=
Date:   Fri, 18 Feb 2022 06:53:05 +0000
Message-ID: <BN9PR11MB54839B6D444DCEB7FD789F33E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
 <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
In-Reply-To: <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
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
x-ms-office365-filtering-correlation-id: b99a5dd0-cffd-414a-8202-08d9f2ab50ee
x-ms-traffictypediagnostic: BN8PR11MB3604:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB36041672DEABB549EB6D5454E3379@BN8PR11MB3604.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iSJjjoJq5FmVnh8qC3ZDB9i5viHa/gstmcXkqjPslTI7LvJT9FuFswy8rx89v0/wZX3SHK80aFVrmOWk5rCumkWcQpxefJEbc5wgaNLZ2z2w/6huN+tGhm98NTNTYy96wL3MHzIJFBGwvmZb0+1yGHiLKbYI+E8DrNv471ZleV8fVtmNyCZgtXD/FgIbxnXXbk2wdggIWcdul0aYx/o/SUrnFuEdQf9TSeBNrFRE+cwl4xq3+dbl8jO2Cj1/ib6RRukuKqZ6VBjVat4SPbdBtQ6mOSmSqp47YpEgjNGy15f/NjRPHtvAUa7Kb3JULrzS3ctxN9OZFILGXBN5Q22pIF0v5BGU06waEE+ZNHSFfP9lvwjDwSiwqm6Nksalc8Lya32QLHJlsyhuSRlBXYOXdrVrccWv9WmmCrem++Hh0vHsVSq1OzE/fA4DpZlUOY0ozbLbvqmwTl3yzhINwzFb9LkpesgWN+rIG8cZ67xUXIS+pQn1rX79MsGa/qwV9PMHb21dmhE43gUD+Ar4N8BnpOTOH1E3NRj2qFpigzQjoXkuMFSVZ1ImccJlx692p6UTjEtsdLdEy2ikzKzDeCFxsb2Uv0RfIHCz1fBtePxnF5+NVwwCjTADXGg/jnXNEOKA4ukDtDvF0PzAXfksq5l4948kzwdQjs1mSaQc6YkvG/WJPMHB6ay2mwHCrU7+8WSHpP0sG/O0sh9mBDGXSo5h9JPBoGkTojLsAWi0/GuMsj9VvNJo68aX7ZBFga1sqUf36GYj74bRwauz21rmYHlliStl5H38hafhAoGkCAIfw+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(76116006)(66946007)(8676002)(66556008)(64756008)(66476007)(66446008)(966005)(38070700005)(4326008)(52536014)(186003)(26005)(508600001)(5660300002)(6506007)(7696005)(2906002)(9686003)(33656002)(8936002)(122000001)(110136005)(82960400001)(38100700002)(316002)(53546011)(86362001)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pVcE5IMVhJUW5hRkdzenBaaGh0d1c1cDd2UnFUNXgxYzRpNGN3NXBXL2pl?=
 =?utf-8?B?MU9WaXpnbk5FQ2YrTFFqOVdBL09YZ2NIMUI4dmR2Q1ZOWjliMDBoZE9aUzhG?=
 =?utf-8?B?MWlreUNwSnE0cTlwS0ZsWHNBa1RsaVFFMVpqRHFnRDF4U3pRbE0yTGsvcUNj?=
 =?utf-8?B?SGRKMEhJTDduL1ZaZmdQTmt5WjR6Nlc2dG9SQ2JjWDlkWTlWN1RxNkQxWkor?=
 =?utf-8?B?RnRXL1U2eHN1OGFpY0M4WjJmaFp2MEppRFRFTlJJaUZPaWxKOVpsOTkrYUt2?=
 =?utf-8?B?UThrZkdpNSs2M0NLVE5aaXJIaFE3cFZNUEFtVVpYR3BNWXpOYTNhcXNIeTlr?=
 =?utf-8?B?c2JGOWpITkJUbzNjYmJxNHBMU0N4N0VMQ1JyT1E0c0JjWGE1NnE1VlV6cHpT?=
 =?utf-8?B?eFFKNHVKSFNVYVhkOFNvT1Y1Z05NZERpTFFmRnVOQWNzSGVzQzYrcjZxbGtX?=
 =?utf-8?B?d1llWXFCWWdNNVI5aVR6d2lSZThyd3NHYkgvaHJwOVcyTmNoMTdQTU4rZkpt?=
 =?utf-8?B?QjV6bmZoNTlPT2NZc2xpSDBScGxTUjBhWkhzcE5TSDRNUmg3ZFZHYUQ1WS9q?=
 =?utf-8?B?YmZ1am1VYVRPWFc3bDdMWEQ3QnJTOXY3MlBWeWc0dCtVMUd1YkJuUFd1cTlD?=
 =?utf-8?B?UGVvNzFySUdTQ0RpcURBRGUyUVhLcFhIb3ZZVlkyNU5GN0o1aXpWa3llM0k2?=
 =?utf-8?B?d0dUdVhVSGdwajZvQzZtVXlJeXhPdFBIak0zSjFWdG8zVXBSMzdWUHFBQzJO?=
 =?utf-8?B?TXBXL0JPZGM3dndLWU5IdlNUOWRXUS9iTTVDaUJJMjIzV04zclFQQmE0UWdW?=
 =?utf-8?B?WWhCNWhpU1BJSWdtd3diekZ4enFuMGtKZHRsT29jT0JjTWpwWm9VbFlBaFFS?=
 =?utf-8?B?bHNueDhDQ1RMSk4rZHZuRENrTEF2emRvSlA1Tk1DR3ZQYVVNZzltTlRHY3Fx?=
 =?utf-8?B?UllSNzRoZVcwdmh2WUpzWUJISmhQSnpHcVhrQ21SWnQ4QXRiQ0NnZVBtMFJm?=
 =?utf-8?B?Q3BmZlpWTVNiRjRwb1VTSnYxOHR3anlXRjg4Z3p1dERBSk1QVllzaUdrUFpT?=
 =?utf-8?B?aWlzS29ka2ZUajQwa1J2M1VBRytRMWE4eVNiRFlkR2htb01PTWh4Vld3NzQy?=
 =?utf-8?B?aU1mRnBsdGVyTVhkcGZjVk41WGYydHlIMHIrUzAvL2NJOE1kUSs4c2VPRmFV?=
 =?utf-8?B?TXFDamJjdTJxUjFidXBIckw0M3haMXFvVC9ET3NuZ0poVWsrQXgxbjNLZm94?=
 =?utf-8?B?QU5iVC9QaEpYSEFMVk5LaFBqYkpCR2xkejA4MWpkcHcrU0ZBTEJ6a005S3Jh?=
 =?utf-8?B?YjFMWEp4citnVUUxL2c5OCtBb25tQlovQVg1b2EyTy8yZWN1eFYwTENrN24w?=
 =?utf-8?B?ZTZMcWZJeXZJU0h5ZVJtOWNCOE1zWW5DN2VDSEZyQlYwUzU3L3ptcWFXMmMy?=
 =?utf-8?B?Q0FTTE4xcTNFYkI0azlqTmp5ZU40SDExMWNLMFFxbytGbThyZlBwYUR5VFdF?=
 =?utf-8?B?b1FkWmV5a1dudWI5R3pabzVaUk10cWtSYkQxSnlEdmE2c3Q0d1RkT0FEeDZp?=
 =?utf-8?B?VXVUbC9Fd29hczlHNGQ4ZHo0eUNkQWZ3UFRzT0txT2hkc2ZVbFVQaTJmWlJt?=
 =?utf-8?B?MmljRFBPTStrSW5Wb21qZCtQWkd3Q2xEWGU4VnBWRWhXN0tVM25pOEhadzVk?=
 =?utf-8?B?QjdUQ0ZhK1lPb1MxdzhDNEQxT1RYMDBtOTczbWEzVjRGOWtCSmpIbnFEQkg1?=
 =?utf-8?B?ekczOXZRQ1VwS2lGUDNLdVNXQTNRTFhaYVN0VDFhZlNINVQyY0lHUmdIbEpM?=
 =?utf-8?B?RXBlOVZQYndFa2NxMWtCZXlSSFlLZlZRZm55bENnZVhlZGRMOHkrL1RHQndN?=
 =?utf-8?B?VWJ2NElqaWdDcDR5TDlkcnJCWWtLSDgyNTN0cmlzMWdRTnNaZmd2Z0x2YjJX?=
 =?utf-8?B?dDNHMjh6VHdLam1uYS9NRGRNL2xYTEF6SXlmdjkvRmhwMEhieTgyUE9TWFVY?=
 =?utf-8?B?bjZKZU9rTzJpTzdOakRtMjJYN3MreHh4bTI3V2pUV2dDTmdFbzM3RnlBZm9w?=
 =?utf-8?B?cStONzdWZTdzRVpaOE96cUtNUng1WThIZjF0MmowVno4TWVnRW8ySDAvUXpn?=
 =?utf-8?B?T2hJNUIwMWNZWC9mNVVTUStJREVsTnRPT3ZPS1M0UFZ3Y05OSHloY0t1Nnhy?=
 =?utf-8?Q?nNFYvYUDc+C9TnRjCrKX3/Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99a5dd0-cffd-414a-8202-08d9f2ab50ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 06:53:05.9367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGChDMzvjOrDVw+uZM8UH/lqB/PxbBoc3eBp2LdeYlxigeDWZcRDBr23+obzAMR7UfhniJoLFuSK+8zsS+8iRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVG9tIFJpeCA8dHJpeEBy
ZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxNSwgMjAyMiAxMDo0OSBQTQ0K
PiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgV3UsIEhhbyA8
aGFvLnd1QGludGVsLmNvbT47DQo+IG1kZkBrZXJuZWwub3JnOyBYdSwgWWlsdW4gPHlpbHVuLnh1
QGludGVsLmNvbT47IGxpbnV4LWZwZ2FAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1kb2NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBjb3JiZXRA
bHduLm5ldA0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIvN10gZnBnYTogZGZsOiBjaGVjayBm
ZWF0dXJlIHR5cGUgYmVmb3JlIHBhcnNlIGlycSBpbmZvDQo+IA0KPiANCj4gT24gMi8xNC8yMiAz
OjI2IEFNLCBUaWFuZmVpIHpoYW5nIHdyb3RlOg0KPiA+IEZyb206IFRpYW5mZWkgWmhhbmcgPHRp
YW5mZWkuemhhbmdAaW50ZWwuY29tPg0KPiA+DQo+ID4gVGhlIGZlYXR1cmUgSUQgb2YgIlBvcnQg
VXNlciBJbnRlcnJ1cHQiIGFuZCB0aGUgIlBNQ0kgU3Vic3lzdGVtIiBhcmUNCj4gPiBpZGVudGlj
YWwsIDB4MTIsIGJ1dCBvbmUgaXMgZm9yIEZNRSwgb3RoZXIgaXMgZm9yIFBvcnQuIEl0IHNob3Vs
ZA0KPiA+IGNoZWNrIHRoZSBmZWF0dXJlIHR5cGUgV2hpbGUgcGFyc2luZyB0aGUgaXJxIGluZm8g
aW4NCj4gPiBwYXJzZV9mZWF0dXJlX2lycXMoKS4NCj4gDQo+IFRoaXMgc2VlbXMgbGlrZSBhIGJ1
ZyBmaXggYW5kIG5vdCBwYXJ0IG9mIGlvZnMgZmVhdHVyZS4NCj4gDQo+IFNwbGl0IHRoaXMgb3V0
IG9mIHRoZSBwYXRjaHNldC4NCj4gDQo+IFRoaXMgaXMgYSB3b3JrYXJvdW5kIGEgaGFyZHdhcmUg
cHJvYmxlbSwgdGhlcmUgc2hvdWxkIGJlIHNvbWUgY29tbWVudHMgdG8NCj4gdGhlIGVmZmVjdCB0
aGF0IHlvdSBjYW4ndCB0cnVzdCBfdGhpc18gb3IgX3RoYXRfIGZlYXR1cmUgaWQgYW5kIHNvbWUg
c3BlY2lhbA0KPiBoYW5kbGluZyBlYXJsaWVyLg0KPiANCj4gVGhlIGFtYmlndWl0eSBvZiBmZWF0
dXJlIGlkIGlzIGEgcHJvYmxlbSwgYW5kIHRoaXMgc29ydCBvZiBidWcgd2lsbCBoYXBwZW4gYWdh
aW4uDQo+IA0KPiBXaGF0IGNhbiBiZSBkb25lIHRvIHByZXZlbnQgdGhpcyBpbiB0aGUgZnV0dXJl
ID8NCg0KVGhpcyBwYXRjaCBpcyBub3Qgd29ya2Fyb3VuZCwgdGhpcyBpcyBhIGJ1ZyBmaXggZm9y
IERGTCBkcml2ZXIuIA0KVGhlIHJvb3QgY2F1c2UgaXMgdGhhdCBETEYgZHJpdmVyIG1pc3MgY2hl
Y2sgdGhlIGZlYXR1cmUgdHlwZSB3aGlsZSBwYXJzaW5nIHRoZSBpbnRlcnJ1cHQgaW5mb3JtYXRp
b24sIA0KYmVjYXVzZSBzb21lIEZlYXR1cmUgSURzIGFyZSBpZGVudGljYWwgYmV0d2VlbiBGTUUg
YW5kIFBvcnQsIGxpa2UgUE1DSSBpbiBGTUUgYW5kICJQb3J0IFVzZXIgSW50ZXJydXB0Ig0KaW4g
UG9ydC4NClRoZSBkZWZpbml0aW9uIG9mIEZlYXR1cmUgSUQgaXMgaGVyZToNCmh0dHBzOi8vZ2l0
aHViLmNvbS9PUEFFL2xpbnV4LWRmbC1mZWF0dXJlLWlkL2Jsb2IvbWFzdGVyL2RmbC1mZWF0dXJl
LWlkcy5yc3QNCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkgWmhhbmcgPHRp
YW5mZWkuemhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9mcGdhL2RmbC5j
IHwgMTEgKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC5jIGIvZHJpdmVycy9mcGdh
L2RmbC5jIGluZGV4DQo+ID4gNTk5YmIyMWQ4NmFmLi4yNmY4Y2Y4OTA3MDAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9mcGdhL2RmbC5jDQo+ID4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC5jDQo+
ID4gQEAgLTk0MCw5ICs5NDAsMTQgQEAgc3RhdGljIGludCBwYXJzZV9mZWF0dXJlX2lycXMoc3Ry
dWN0DQo+IGJ1aWxkX2ZlYXR1cmVfZGV2c19pbmZvICpiaW5mbywNCj4gPiAgIHsNCj4gPiAgIAl2
b2lkIF9faW9tZW0gKmJhc2UgPSBiaW5mby0+aW9hZGRyICsgb2ZzdDsNCj4gPiAgIAl1bnNpZ25l
ZCBpbnQgaSwgaWJhc2UsIGluciA9IDA7DQo+ID4gKwllbnVtIGRmbF9pZF90eXBlIHR5cGU7DQo+
ID4gICAJaW50IHZpcnE7DQo+ID4gICAJdTY0IHY7DQo+ID4NCj4gPiArCXR5cGUgPSBmZWF0dXJl
X2Rldl9pZF90eXBlKGJpbmZvLT5mZWF0dXJlX2Rldik7DQo+ID4gKwlpZiAodHlwZSA+PSBERkxf
SURfTUFYKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAgIAkvKg0KPiA+ICAg
CSAqIElkZWFsbHkgREZMIGZyYW1ld29yayBzaG91bGQgb25seSByZWFkIGluZm8gZnJvbSBERkwg
aGVhZGVyLCBidXQNCj4gPiAgIAkgKiBjdXJyZW50IHZlcnNpb24gREZMIG9ubHkgcHJvdmlkZXMg
bW1pbyByZXNvdXJjZXMgaW5mb3JtYXRpb24gZm9yDQo+ID4gQEAgLTk1OSwxNiArOTY0LDIyIEBA
IHN0YXRpYyBpbnQgcGFyc2VfZmVhdHVyZV9pcnFzKHN0cnVjdA0KPiBidWlsZF9mZWF0dXJlX2Rl
dnNfaW5mbyAqYmluZm8sDQo+ID4gICAJICovDQo+ID4gICAJc3dpdGNoIChmaWQpIHsNCj4gPiAg
IAljYXNlIFBPUlRfRkVBVFVSRV9JRF9VSU5UOg0KPiA+ICsJCWlmICh0eXBlICE9IFBPUlRfSUQp
DQo+ID4gKwkJCWJyZWFrOw0KPiANCj4gSW5zdGVhZCBvZiBlbWJlZGRpbmcgYSBicmVhayBpbiB0
aGUgc3dpdGNoLCBicmVhayB0aGUgc3dpdGNoIGludG8gZm1lIHN3aXRjaA0KPiBhbmQgcG9ydCBz
d2l0Y2gNCj4gDQo+IGlmICh0eXBlID09IFBPUlRfSUQpDQo+IA0KPiAgwqAgcG9ydC1zd2l0Y2gN
Cj4gDQo+IGVsc2UgaWYgKHR5cGUgPT0gRk1FX0lEDQo+IA0KPiAgwqAgZm1lLXN3aXRjaA0KDQpZ
b3VyIHN1Z2dlc3Rpb24gaXMgbG9va3MgZ29vZCAgZm9yIG1lLCBJIHdpbGwgY2hhbmdlIG9uIG5l
eHQgdmVyc2lvbi4NCg0KPiANCj4gVG9tDQo+IA0KPiA+ICAgCQl2ID0gcmVhZHEoYmFzZSArIFBP
UlRfVUlOVF9DQVApOw0KPiA+ICAgCQlpYmFzZSA9IEZJRUxEX0dFVChQT1JUX1VJTlRfQ0FQX0ZT
VF9WRUNULCB2KTsNCj4gPiAgIAkJaW5yID0gRklFTERfR0VUKFBPUlRfVUlOVF9DQVBfSU5UX05V
TSwgdik7DQo+ID4gICAJCWJyZWFrOw0KPiA+ICAgCWNhc2UgUE9SVF9GRUFUVVJFX0lEX0VSUk9S
Og0KPiA+ICsJCWlmICh0eXBlICE9IFBPUlRfSUQpDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICAgCQl2
ID0gcmVhZHEoYmFzZSArIFBPUlRfRVJST1JfQ0FQKTsNCj4gPiAgIAkJaWJhc2UgPSBGSUVMRF9H
RVQoUE9SVF9FUlJPUl9DQVBfSU5UX1ZFQ1QsIHYpOw0KPiA+ICAgCQlpbnIgPSBGSUVMRF9HRVQo
UE9SVF9FUlJPUl9DQVBfU1VQUF9JTlQsIHYpOw0KPiA+ICAgCQlicmVhazsNCj4gPiAgIAljYXNl
IEZNRV9GRUFUVVJFX0lEX0dMT0JBTF9FUlI6DQo+ID4gKwkJaWYgKHR5cGUgIT0gRk1FX0lEKQ0K
PiA+ICsJCQlicmVhazsNCj4gPiAgIAkJdiA9IHJlYWRxKGJhc2UgKyBGTUVfRVJST1JfQ0FQKTsN
Cj4gPiAgIAkJaWJhc2UgPSBGSUVMRF9HRVQoRk1FX0VSUk9SX0NBUF9JTlRfVkVDVCwgdik7DQo+
ID4gICAJCWluciA9IEZJRUxEX0dFVChGTUVfRVJST1JfQ0FQX1NVUFBfSU5ULCB2KTsNCg0K
