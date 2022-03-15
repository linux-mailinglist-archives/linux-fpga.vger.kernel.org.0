Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0534D9899
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Mar 2022 11:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiCOKTV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Mar 2022 06:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbiCOKTU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Mar 2022 06:19:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB5414039
        for <linux-fpga@vger.kernel.org>; Tue, 15 Mar 2022 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647339488; x=1678875488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yAJY9efHDBMW7FQ3xCsgnJiFCTeKoHuMO/1jgv5iLQw=;
  b=iKCtSb5UEPdFFaCmjKNbqIws3OG3/5QlsplSvj3AdZYCjBfPasFKiteF
   Qv9TzsfF/XHaB0BeELbgsEocmI+Qmz50VR1uWNRVYUeuXRCA4QormQkH/
   ++5aQh138zS1F92ie2g+3QUpdeURrrUXQK2BP3mMT6AEfMyfluVE5WXVT
   SgL92ypu+sBWxzxv59lWDOppe8nSdE4nYiHYrtjupogoNIhzPjE2e0uXG
   28OapgvPP+IAjvqFtdMg5ouU84g5ZaJI31AkPXQZ43RGH+vsNResv0nv4
   Z4UsFDh7b89L31xE1fPegTX9hgU1lsLtchbSqOf8m8owcmcLjRotcBeH9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256453825"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="256453825"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="783016690"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2022 03:18:08 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 03:18:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 03:18:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 03:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKI5X3PaqT5kOv6NBVNZQI+rN+csje9Jm+XKXuX+cLfG5NIv556/RqDITIXSem8gXLehyQuBT3aOyTHFySF4i1vQVMZgm5Ja19zStS2U6ZpEJo5oBCCrhY+MJAYctcRipocP0QQDE2+4AkN6a65bCqM9hDAWdNIn4gS+jaVf3sY5NzUSP32BO+WOSfsOuFls7w5HODnGXsUolXnv78JdZPQ8nsuT26/e65Mn87wMo4gIiJiYwGM2JaE7HzHoRYU3yX54uE2H3Gk2IpADp9pz3tOSqN0ZfLHG2hx+ka6g2B4F/RQ6j0mQZRyjOLpq/XVVP1L8QN0u18PRNvmpZcxJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAJY9efHDBMW7FQ3xCsgnJiFCTeKoHuMO/1jgv5iLQw=;
 b=EPjTEBDOIJ+Dd1Yd2UU6h20+MhyJchTcJgyUjq+PxLN8w7CW/9+rrVZDHIw3SmUYdpc43qAt3Bo4yVBHHp+D1wqjN2G6LLgMG62me2NAjTUK4e6OVusZZIyLtX7pX9ZWxDHSJmI066phiMAIFsZsT7tpKgkZ3OWJNzxvGevyjlUcs53NOiooSOUeAayxfLtNO5axDlnLyQPLwpYV9DpghL9GnpdkV3Srx0eOaK0u5hZq9MIGN4gQQ0q165MF2ZZor79h+w294KiOrdcvwVbm3Iayc/XB+Mw+wcZaKEefZSnCWNMtIDnWWCJlpkGu4j6Bn9vwDxhd01gcLBu8QUxrmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5477.namprd11.prod.outlook.com (2603:10b6:208:31f::19)
 by DM6PR11MB4026.namprd11.prod.outlook.com (2603:10b6:5:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 10:18:04 +0000
Received: from BL1PR11MB5477.namprd11.prod.outlook.com
 ([fe80::edd1:8494:b5bb:3b64]) by BL1PR11MB5477.namprd11.prod.outlook.com
 ([fe80::edd1:8494:b5bb:3b64%8]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 10:18:04 +0000
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
Thread-Index: AQHYMrhKml+FZWGpG0uUYk5qH7zFV6y5BeCAgAB5IgCAADjzYIAEhEiAgABuVrCAAY8JAIAAC8Lw
Date:   Tue, 15 Mar 2022 10:18:04 +0000
Message-ID: <BL1PR11MB54772E1517EEE39B1091836EE3109@BL1PR11MB5477.namprd11.prod.outlook.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
 <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
 <DM6PR11MB3819A43505B9986593143C21850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483722F9156F6EBA53126B4E30C9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819715B8A7DF03DDD19F7E9850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483A25DF3AEF87F83AA4A9DE30F9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB3819F9A80C12E0253ED1594B85109@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819F9A80C12E0253ED1594B85109@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 8708550f-cd70-4374-0742-08da066d17c7
x-ms-traffictypediagnostic: DM6PR11MB4026:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB40261C8A1A24296AF4414D67E3109@DM6PR11MB4026.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRe4qRMqj2WITLnjP3ievLYVPmhJr1dyVMT4hU+xQzTk0vB6rzGh3RXQQ3QBY/zmtBo57yp6Cmno8cGSF/fiKS6aJU/wDPmwXpSx8ap7L4TJeQPI+cZ539eFtVaunmN4XfdO1FdoL/nCGlz39+V+lJwa7BO4A3AraBzP9bcY9JgVCHII8PfxsShQlv2vQl9sUBcr6X/CikxYuzrIfd9ntcPoOvZI5ps06z8GWtfuoVZbYxdkmaV8TLblBQRV5IkeKKwigXjcnQhdViB63xwYua0mUZRLWG2UP8vKFjtK4AjopjRE6Z3DHghLJLCTSLQxeYn6aIXAE1jkKDq8UKnWNOWYiW4u/ZLiTP1gBXyYctfsbQ8WET9WEPqSh8ZhMuieLC2wpxZLNIw7UhFUH7y1WhGQUsKaunJOKxXGW0wvISEUQ+gMrJm9aEscJ7ZQ4AkPp1OFFzgcxqPTKv6VBqagt3H0oIGA1OEXdkGHEx2p7/jGvSVxIDKgYiTDKbcusAvM0BvP/Ek0QV4p0rLGvALCuKAsOQwGf1YmC6yv5hgNPmAMiRHNbr2XKvRZSVpHMW1XVoyaC1yEvzGwowcfngCU1eohifdnCNKOKSSWOBQIYAiSA8+lByPBDmj+4HQ42Xkzo7lDAmKxhj4MIL8LHHmbS21pIva1LiJdwpDCDbH4XJ7V9bsWpbzEo18/cuWR0Fapd1X5d/oL5xe6fRiLGvXllignHQEbaitGwDXL2tfyY/x8iVrC/asPere5NuRPs8lddwLAo/6x6Fpcu+88ntLqbGBRvS/LYupNlALgUAMLrMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5477.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(5660300002)(52536014)(8936002)(122000001)(2906002)(82960400001)(66476007)(83380400001)(76116006)(186003)(64756008)(66446008)(508600001)(38070700005)(33656002)(66946007)(66556008)(4326008)(26005)(316002)(7696005)(8676002)(6506007)(53546011)(110136005)(71200400001)(966005)(55016003)(54906003)(86362001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVBLMnhESzUvMzRSQWwxVWxZOHk4U1dZUUlTSXVEaFhaYXJmKzBJNmxFQXB1?=
 =?utf-8?B?RkFQY0xidFdYbkYwc1RaSXh4OHJWVzNVb2cxcG1oNFJWQnY1UkxZcG16MmJU?=
 =?utf-8?B?bllqOFFaaTRUajRQMlhIT3pPaXBJQUxsL1JLZWMxcG4yaHhNVllYQjEwZEsv?=
 =?utf-8?B?a2VOREc3dlRVVk0waGlVSTMvQjNNa3ZIb2ROWGduSTlqaW1XSjIwRGMySEhW?=
 =?utf-8?B?MTdjdmtzUS8vMWFXeVFiTTc2a0hod3lOY0c4QWZWSDVVeFpQbXhTa0VwRmdW?=
 =?utf-8?B?MHV3Ym0zTXY4MnVWNTE1VDJTaTJsVzZTOTQ2YWorVStFTGt2SHg4cGtwcXl5?=
 =?utf-8?B?TVZ3OXg1dmtsVHl3bFFwZGZuRHlya1lTT1F5a1BFYW9DV2RUd21xKzdTOEJw?=
 =?utf-8?B?S0lZK0UyRHplZjNHaTdKL1haRVUxRzU4V29xWURGOTBlWnhNMXNrK2hNOVFN?=
 =?utf-8?B?MkNKUjloT1oyZ05oL3JnSVdIZS9MMHB5RGYybmZ3VCsvaEMyUWlsWWdVWkRq?=
 =?utf-8?B?cGh5SVNpLytVQ3Bzd2xJMVcwTE1XSnR3c1gwVXgweExFVTBCbm16SWNwcG15?=
 =?utf-8?B?NGlJampDaHBTbE5SbzFhejB6QVl3bUtmUTlFbnVzVnBhWno2N3FNTW5LSjFu?=
 =?utf-8?B?THlrVmdTcUlCdWdiSTVLSEpBeW9hUlVBcVN2d21jYk1MdW9ZWUNQeFZFSGdZ?=
 =?utf-8?B?WXkzMWlCeW1SK0R0YjY1VUlhdGZJejF6Wk9MUnNWcU1kQzJMMlBYTWN4WStU?=
 =?utf-8?B?RUpVU0srR2pOVDFsell1UDgreStTUlB3UjlmUEI3YU9TVUVFV0t0TWJoNFJu?=
 =?utf-8?B?Vkp1S3pRVjd5Uk02VFYvZTMxL0pUVTdiSW90N2ozblZ0T1ZFQ3MzYUxGa1hj?=
 =?utf-8?B?NWpibTRKRlQ0NnNhd094c0YzQTNaNDNaT2hlOXdxSVlpd3NOcVVzODVJb2JF?=
 =?utf-8?B?bnRwNUJuNVJ4MU9lYm1OY1JONWhaRWlCUUFGOEJJTHR6MVJGNFczU3NMV08y?=
 =?utf-8?B?ckcxY3dRWTZpazZ0Q0E2NHRxUVhjdGpyeWtoYklnWk9QU3lqblZzNStZYXha?=
 =?utf-8?B?c1JJbzdGdjBSd1ZhK1FicXp2akp4cjkwa3hHR1REYUFQMk1vSmNqRlpkZDdk?=
 =?utf-8?B?Mk9aYWVxSXo3UnRtM0NRY01rYW44Zm9EZjBSWnF1WVIvRy8waVZiMjkrdlE5?=
 =?utf-8?B?QjJwS3RnT1hCbkhlV1FpRVkxVUovRndIaE9sVWVQQkxsenJZYW1mSGh3eG02?=
 =?utf-8?B?N0FSbHlLRFFFMCszWXdzN2hPRlpIQVo0RmtKZjB3TDZWcFFzUlZYRGg1dkt3?=
 =?utf-8?B?RGo4Y3Q3blJaam92NEtySGx6SGxNamtYc3ZvOERqWU9HWHVXSVNSeFIvMWtl?=
 =?utf-8?B?UFlDV1JOcTIxS2JReG1JdWJkNkVuK0dwZGVPQWFiWVhlbG9FeHVSb1U3U0kw?=
 =?utf-8?B?c1lvQ1JnSlpIcmw2T2FhQmpKLy9QZ3ZPYWpvN3hwWHFJZXJXUUg3R242bFd4?=
 =?utf-8?B?MU9jNTR1R0p5enJZNVhzTktrQ0VUcHpPempNczhpbXpYMzZjR2ZVV1orcTZG?=
 =?utf-8?B?UWVZUXU2SFVDbFNsUC9oODcxaDlrUE5pVlQ3cS9uc3hUejFNajZUNEg1QWs3?=
 =?utf-8?B?ZGFvU0owelI4Tk1KT1VoOW1NeTJmWVJOSytwRThOcVA4SWFaRmMyQnlFNVh6?=
 =?utf-8?B?L1RCcjAxVkdnOUozVTVWRUlEenltTThKMk93S3Fud2lVTC81VndUZTZLenZY?=
 =?utf-8?B?d29hL0JBdjBGUEpzL1IvcEcrRXFGVjdtSkprTzNYN1FCbk5HbmhaSGZteFZV?=
 =?utf-8?B?eXE2QS9pa3dkOTZTMFlMOFBFRE5kNVY3TkYzNmNsU3QvbmZuZTgxczRwbXZ1?=
 =?utf-8?B?cDhRSjRJNVFVa0dBR1czR0lCdERIaXBpU2pSaTlyNWFqWUhyT1o4ZUswY0p6?=
 =?utf-8?Q?TN1HEGBx2ORCgsxVRjgaKSVTG9Pw3h8W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5477.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8708550f-cd70-4374-0742-08da066d17c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 10:18:04.5218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1K5LCcsCeRUG04r8WkbkAwgQZ2V/x23kfeaiwnfK9FQIuHnep0y8qQAciy1ug4RGg4wvIw2eoxpbEeBuZZXdfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4026
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV3UsIEhhbyA8aGFvLnd1
QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTUsIDIwMjIgNTozMiBQTQ0KPiBU
bzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsgV2VpZ2h0LCBSdXNz
ZWxsIEgNCj4gPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsgdHJpeEByZWRoYXQuY29tOyBt
ZGZAa2VybmVsLm9yZzsgbGludXgtDQo+IGZwZ2FAdmdlci5rZXJuZWwub3JnOyBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZw0KPiBDYzogWHUsIFlpbHVuIDx5aWx1bi54dUBpbnRlbC5jb20+OyBN
YXR0aGV3IEdlcmxhY2gNCj4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjFdIHVpbzogZGZsOiBhZGQgSFNTSSBmZWF0dXJlIGlkDQo+IA0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFd1LCBIYW8gPGhh
by53dUBpbnRlbC5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIE1hcmNoIDE0LCAyMDIyIDExOjA5
IEFNDQo+ID4gPiBUbzogWmhhbmcsIFRpYW5mZWkgPHRpYW5mZWkuemhhbmdAaW50ZWwuY29tPjsg
V2VpZ2h0LCBSdXNzZWxsIEgNCj4gPiA+IDxydXNzZWxsLmgud2VpZ2h0QGludGVsLmNvbT47IHRy
aXhAcmVkaGF0LmNvbTsgbWRmQGtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC0gZnBnYUB2Z2VyLmtl
cm5lbC5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnDQo+ID4gPiBDYzogWHUsIFlpbHVu
IDx5aWx1bi54dUBpbnRlbC5jb20+OyBNYXR0aGV3IEdlcmxhY2gNCj4gPiA+IDxtYXR0aGV3Lmdl
cmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MV0gdWlv
OiBkZmw6IGFkZCBIU1NJIGZlYXR1cmUgaWQNCj4gPiA+DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBXdSwgSGFvIDxoYW8ud3VAaW50ZWwuY29t
Pg0KPiA+ID4gPiA+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMTEsIDIwMjIgMTA6NDcgQU0NCj4gPiA+
ID4gPiBUbzogV2VpZ2h0LCBSdXNzZWxsIEggPHJ1c3NlbGwuaC53ZWlnaHRAaW50ZWwuY29tPjsg
WmhhbmcsDQo+ID4gPiA+ID4gVGlhbmZlaSA8dGlhbmZlaS56aGFuZ0BpbnRlbC5jb20+OyB0cml4
QHJlZGhhdC5jb207DQo+ID4gPiA+ID4gbWRmQGtlcm5lbC5vcmc7IGxpbnV4LSBmcGdhQHZnZXIu
a2VybmVsLm9yZzsNCj4gPiA+ID4gPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPiA+ID4g
PiA+IENjOiBYdSwgWWlsdW4gPHlpbHVuLnh1QGludGVsLmNvbT47IE1hdHRoZXcgR2VybGFjaA0K
PiA+ID4gPiA+IDxtYXR0aGV3LmdlcmxhY2hAbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiA+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjFdIHVpbzogZGZsOiBhZGQgSFNTSSBmZWF0dXJlIGlkDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IE9uIDMvNy8yMiAyMjo0MywgVGlhbmZlaSBaaGFuZyB3cm90ZToN
Cj4gPiA+ID4gPiA+ID4gRnJvbTogTWF0dGhldyBHZXJsYWNoIDxtYXR0aGV3LmdlcmxhY2hAbGlu
dXguaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBBZGQgdGhlIGZlYXR1
cmUgaWQgb2YgdGhlIE9GUyBIaWdoIFNwZWVkIFNlcmlhbCBJbnRlcmZhY2UNCj4gPiA+ID4gPiA+
ID4gc3Vic3lzdGVtIHRvIHRhYmxlIG9mIGlkcyBzdXBwb3J0ZWQgYnkgdGhlIHVpb19kZmwgZHJp
dmVyLg0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3
IEdlcmxhY2gNCj4gPiA+ID4gPiA+ID4gPG1hdHRoZXcuZ2VybGFjaEBsaW51eC5pbnRlbC5jb20+
DQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRpYW5mZWkgWmhhbmcgPHRpYW5mZWkuemhh
bmdAaW50ZWwuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBSdXNz
IFdlaWdodCA8cnVzc2VsbC5oLndlaWdodEBpbnRlbC5jb20+DQo+ID4gPiA+ID4gPiA+IC0tLQ0K
PiA+ID4gPiA+ID4gPiAgZHJpdmVycy91aW8vdWlvX2RmbC5jIHwgMiArKw0KPiA+ID4gPiA+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91aW8vdWlvX2RmbC5jIGIvZHJpdmVycy91aW8v
dWlvX2RmbC5jDQo+ID4gPiA+ID4gPiA+IGluZGV4DQo+ID4gPiA+ID4gPiA+IDg5YzBmYzdiMGNi
Yy4uNjYwZTFkMGJmNmI5IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Vpby91
aW9fZGZsLmMNCj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91aW8vdWlvX2RmbC5jDQo+ID4g
PiA+ID4gPiA+IEBAIC00NSw5ICs0NSwxMSBAQCBzdGF0aWMgaW50IHVpb19kZmxfcHJvYmUoc3Ry
dWN0DQo+ID4gPiA+ID4gPiA+IGRmbF9kZXZpY2UNCj4gPiA+ID4gPiA+ID4gKmRkZXYpIH0NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gICNkZWZpbmUgRk1FX0ZFQVRVUkVfSURfRVRIX0dS
T1VQCTB4MTANCj4gPiA+ID4gPiA+ID4gKyNkZWZpbmUgRk1FX0ZFQVRVUkVfSURfT0ZTX0hTU0kJ
CTB4MTUNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdoZXJlIGlzIHRoZSAiT0ZTIiBjb21pbmcgZnJv
bT8gaXMgaXQgZm9yIGFsbCBPRlMgZGV2aWNlIG9yIGEgc3BlY2lmaWMNCj4gY2FyZD8NCj4gPiA+
ID4gPiBBbnl3YXksIGNvdWxkIHdlIGhhdmUgYSBtYXRjaGVkIG5hbWUgcGVyIHB1YmxpYyB0YWJs
ZT8NCj4gPiA+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vT1BBRS9saW51eC1kZmwtZmVhdHVyZS1p
ZC9ibG9iL21hc3Rlci9kZmwtZmVhDQo+ID4gPiA+ID4gdHVyZQ0KPiA+ID4gPiA+IC1pZHMucnN0
DQo+ID4gPiA+DQo+ID4gPiA+IFllcywgSSB0aGluayBhIG1hdGNoZWQgbmFtZSBvZiBwdWJsaWMg
dGFibGUgd2lsbCBiZSBiZXR0ZXIuIEhvdyBhYm91dCB0aGUgIg0KPiA+ID4gPiBGTUVfRkVBVFVS
RV9JRF9IU1NJIj8NCj4gPiA+DQo+ID4gPiBOby4gV2UgYWxyZWFkeSBoYXZlIHRoZSBzYW1lIG5h
bWUgZm9yIGlkIDB4NiBkZWZpbmVkIGluIGRyaXZlcnMvZnBnYS9kZmwuaA0KPiA+ID4gI2RlZmlu
ZSBGTUVfRkVBVFVSRV9JRF9IU1NJCQkweDYNCj4gPg0KPiA+IElzIGl0IHBvc3NpYmxlIGNoYW5n
ZSB0aGUgIkZNRV9GRUFUVVJFX0lEX0hTU0kiIHRvICINCj4gPiBGTUVfRkVBVFVSRV9JRF9MRUdB
Q1lfSFNTSSIsIGFuZCB0aGUgbmV3IG9uZSBpcyAiDQo+ID4gRk1FX0ZFQVRVUkVfSURfSFNTSSI/
DQo+IA0KPiBJIGFtIG5vdCBzdXJlIHdobyBvd25zIHRoZSBJRCBhbGxvY2F0aW9uIHRhYmxlLCBh
bmQgd2h5DQo+IDB4NiBpcyBjaGFuZ2VkIHRvICJMZWdhY3kiIEhTU0kgYnV0IEkgZmVlbCBpdCdz
IGJldHRlciB0byBoYXZlIGEgc3BlY2lmaWMgcHJlZml4IGZvcg0KPiB0aGlzIEhTU0kgaW5zdGVh
ZCwgSSBob3BlIHdlIGRvbid0IGhhdmUgdG8gY2hhbmdlIHRoaXMgMHgxNSBIU1NJIHRvIGFub3Ro
ZXINCj4gbGVnYWN5IG9uZSB3aGVuIHNvbWVvbmUgYWRkcyBhIG5ldyBIU1NJLiBUaGlzIGlzIGZv
ciBGUEdBLCBldmVyeWJvZHkgY291bGQNCj4gaW1wbGVtZW50IGhpcyBvd24gSFNTSSwgZ2VuZXJp
YyBuYW1lIHNob3VsZCBiZSBhdm9pZCB3aGVuIHBvc3NpYmxlLCBhbmQgYQ0KPiBiZXR0ZXIgcnVs
ZSB3aGVuIG1hbmFnaW5nIHRoZSBmZWF0dXJlIElEcy4NCg0KWWVzLCBJIHRoaW5rIHRoaXMgSFNT
SSB3YXMgZGVzaWduZWQgZm9yIE9GUywgdXNpbmcgIk9GUyIgYXMgcHJlZml4IGlzIGJldHRlci4N
Cg0KPiANCj4gPg0KDQo=
