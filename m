Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9CF4FF329
	for <lists+linux-fpga@lfdr.de>; Wed, 13 Apr 2022 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiDMJQw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 Apr 2022 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiDMJQu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 13 Apr 2022 05:16:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED486472;
        Wed, 13 Apr 2022 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649841266; x=1681377266;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rN1HfMsdttoLj7IFY12MCs1uMUatloxBJSJP80hgxQs=;
  b=TnJ6oLagBNqwejGYC7EhEsb4X4eyxoM5rsnXFU3gQaAzABJ/fFPaJDLS
   Ceb9iVJ6zIX++VeCkdXQrf0oUWFAeq2ALxEUvtScYv+0pCsm6G4XT/sAM
   6pyXZJtdMYOrPU455dzaZXvmNlb3i4C7OD3OdVTseJcHExFf8pBFHMrYx
   +j8CWcsgfiRtqK/oPIrSM46z80uOGZD3zlgk68tGX7dFltTxr+hKvDlaN
   +CLFaY9PVRDn0I2W+XfyQz0nKY5yW21vYmkZisug01SSMTvsMkAXLFZ02
   F6JQ2RPXeq6A9qOP4uXL2I2BUKAd0GC2g22/ROwtBGjZgeNIVOgqsOpOs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261463916"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261463916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="552123468"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2022 02:14:15 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 02:14:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 02:14:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 02:14:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYN6WSrkE27n6oJXBDpzuCfrg3RGD2qb4v60WY9ScoHFKnDa4q8XSdpl4ggRZauqB32FIiVnMln6uOnhLvhJ4IqgDLuAAcxJ3oM9l+gPZGhTXl1l/8bYPcGZePFjCdvpKplpTPdOWgpOCnaq+MiulgL78PNVUbUFe61MUAAHJlQOYvK3IEusyHGd2g0+6IFRcEvumjXBe1xcPzV8SX6Ul66owcTRYjXkNfQsjm4ZLaMoHOQaXJSk3XfOJub0LnIS8krkdfAcuhPbtpiZ9W47V4GsMXkrAAqpCk8DK9Oj45Jm3vTAK7HS6y62Ss7uxCmcszvXHzdUsPUTra86ZQKK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA6aXK3PoLAPpILbN1bJZBx8dBfytfFRuomgelMg3ic=;
 b=VYEzUp0YQ5Cj6g9fMOUyHwoyo9RpRMwbFX5QK4BqqHMLXJbVPVFC4RPHCt4Brp/R69Ra7gUqS61zGSn8zChV4coEUKFcwIV+5jXxftuLWGHEsrcvFClB8NkymWarwRS6+i56u6TSLpP0wEqxXT4CHyKnVLkLaVbPCa3QwNLXfcNOWysxnzZTHRH2v99DKmbzQM0Cs4kyvgysAQmuK1ti7uCmVDeMuPMtVwVCGU1lmkD/PBkEuUmba4CjO0GqY/WtS6v8nyVRFdQs+Tsn0kr/uRRsQDbdsolmk65BbE0xSGIfzpkgr+kzrxBhYErC/XeSFEwaDnXA9W2t7laCFumYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB3480.namprd11.prod.outlook.com (2603:10b6:a03:79::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:13:08 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%7]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 09:13:08 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Topic: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Thread-Index: AQHYOQUcVwr1NO7I9EaBR7STlp8buqzC1K+AgABHRmCAACD9gIAAAOAAgCp8rEA=
Date:   Wed, 13 Apr 2022 09:13:08 +0000
Message-ID: <BN9PR11MB54835DBB0A6A252D78B398A8E3EC9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
 <20220316070814.1916017-2-tianfei.zhang@intel.com>
 <BYAPR11MB3816EAB6CC0047B2DBB5086685129@BYAPR11MB3816.namprd11.prod.outlook.com>
 <BN9PR11MB54839B3ABC5844DF45602995E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
 <DM6PR11MB381901ED86051F8D3117799A85129@DM6PR11MB3819.namprd11.prod.outlook.com>
 <BN9PR11MB5483D95314F5D82F1EE31174E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5483D95314F5D82F1EE31174E3129@BN9PR11MB5483.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 0cc58532-d8fd-4109-3b3d-08da1d2dd38d
x-ms-traffictypediagnostic: BYAPR11MB3480:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3480B858E7825687AB6F9238E3EC9@BYAPR11MB3480.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsItszpKY0xSBWwOOoWufo3VXFOxUBgZlwuv7+Dqg/JbdQAbHZ4YNfmXkgzLzdRGVnYuOgj6qQahK8qY4rWpelau8MLpdqMsX+hFMrcwBYlgFsZg74+qoxNqAwIY4EddzQZ0Tvnkg8ICkscy60I+qd6s+gDu3qBoJIo+Fvfy6zxWCTRjvwepmrQJIvZrWKUyWAIJsVt/de1BsA9vqX/TKCTMYDnekrBCiBHjdybJs5fffz/8QK+NIbWHNuwdMkjo4KavLaEVe3A4Qjb8F0I/Jj4P6BnYfBoXwiYDLBIllyA9mL/RXsydVGJQ47baaGU9GeHZIB3ep/cHl2Y0qSmowSdOuOCMaLw6pUAO3EUhOR/gXSrZMjldBFxI/ScXnmV1RzeN8gPspGd3Sgtw3FleWBI/cjBjyYYEv9X/BSvJ+zEM1e8FE3NrznqDzODzeevCGtlpvGnrafaRkdhzIEnSPhrYMoq4fI1sEtIhnNOxDwLHTyUwKT4BLM3j5IIT232cUaxLEggVJ6sDMZ1anJAR/7qV0OwSflNnAbJe5wTKOV1LE1aN89mlb/Pqn1VMQMcwqOuJ/jX9MlvKRXUDBtzl0Ni5aS8ZqybzU9l3nEHxinytdZJXMEzKDE9cqwuZ5MHoUZaG9jBRkYF0vecwHMWBbsLbLxCRNV/7eJqGyAk1Lmql006jjfaBHIJMfWbCtsRns5hq6GVxJYoJG9cM8SP1auJNb2l7sqr/Zzd0XlWD4/U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(7696005)(921005)(82960400001)(9686003)(2906002)(5660300002)(38100700002)(33656002)(55016003)(6506007)(26005)(83380400001)(38070700005)(52536014)(186003)(53546011)(508600001)(8936002)(4326008)(8676002)(66446008)(66476007)(64756008)(66556008)(66946007)(71200400001)(76116006)(110136005)(316002)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1E4nWMc7eh4GWKLqomThpM5o+t6hHenMfn/7WRS6k7EMo54lolvdLyp6QeIA?=
 =?us-ascii?Q?WzCS5qcCKAfTcH/eD9DIvOOh0+mFJ+T1YpCqn0eyudkfAP3im4Dyp0rCncm6?=
 =?us-ascii?Q?RVI5wXjigzkkZdLe6CdI4nDE8ZgXVnqUHQpLOissAZ2KKAIcg2RYB6MB4b3P?=
 =?us-ascii?Q?DJbbhbCQmj+9O/OUwpUdmtFeyZqHxNd9Z3HX6uSVPdTjg5xz0lnFdV9FU41E?=
 =?us-ascii?Q?DkI0ekU0EftxbszWYJY1OQmBsPgNsMN8OZIoUxty0vKiRIyayvLcbQuDHe9d?=
 =?us-ascii?Q?WtRqqhIxIW6rOIJD5Xg0xgNunbKXJm1jycMJU5dZO2mR917I7jhXaBKB7nhZ?=
 =?us-ascii?Q?6gN6yg0mk3FidYqcgnAAbg3D65ehLDOeGU8FIdiYQiYtViUilN0grc8SUhAz?=
 =?us-ascii?Q?YaVN6aUDivKQOITbv3yVb9cRB17i6a0EbwXo8+X2JqzEHRgJpnhcpx081IPV?=
 =?us-ascii?Q?rJgQfMfK4MO7R/C3WNgnDv3ao/sPJsVYIK4yWM6ylc2yu8Vl3RKu4hR6Cf5s?=
 =?us-ascii?Q?ssl9NpL2ks+GnBvSGbIT09pq1e+dMvgzdDN43ssr7kOyYeTOYCV4mdkRsA5f?=
 =?us-ascii?Q?XTNbXgAk/o6QF8Hw0P8GClO5QJylxlO/hp8LHMiCJM6GkGCDTXwNSB5P8mri?=
 =?us-ascii?Q?zXrBCPKxflPFIKRWuIYt8vy530gXvAY+ZPMA9NmywgJA/ir3XXztz+HEfz27?=
 =?us-ascii?Q?sLNRRX07zn6+g56bQoI2UBwHEUQ17VllhcLmsEvLbTmZnZetAVTGI+0lVK1A?=
 =?us-ascii?Q?Mvu3g9652zf6OUFavNh5UsRnNNR9tGSuPjOJvx4JKRjFCngduuFiM9KcsQpT?=
 =?us-ascii?Q?cSgWbkexM8ZdkRIntQH5DDXYBJVD2AiprJXYGNCMMDQwzxAcUnf+ff1m8Fug?=
 =?us-ascii?Q?gW11j6lNTlxklXmNos4k2Bnst7eXdR7Wp2576ooPbxZD6+lF22m2Ayf6KtjF?=
 =?us-ascii?Q?zIG0ZQsa/xdsjba91PqDAv87mpKkhq4RKf/Kan7l7fuZl12UlPL68GA1Rp5O?=
 =?us-ascii?Q?AKZjZRHiXEYD5BPI82G1OM7h6ukt2HgA2EkcUZhgwYWf4CyPQbb7dgmPNcbx?=
 =?us-ascii?Q?08YQSu+L2pB0SasDPYclIzHT43BW3tgimp/SqhWXEGdCW4kAjqDOgYxvQPUJ?=
 =?us-ascii?Q?843K5nZSirFvsaztg+zNdaFyT/gxQGyCoil17u7XszBb4TCshl3ZXrcf1Fnn?=
 =?us-ascii?Q?osfT5AVrhMAks0sivwUpikqA5OrC13Cfl7ELunnlBqsPYR+SZxGlPSwh8VEz?=
 =?us-ascii?Q?PVPR3ScAVlGp0OXMK1vOpVEh/9A7e3YoZdCc2vNx2uuCESAs0mZV4givETI1?=
 =?us-ascii?Q?weZHTG4X3jyCrtODuZO5KpM1pNuQ7lgq1dI50MpUK3BS/YoMntkH5lxWilKo?=
 =?us-ascii?Q?5vht+dfJ+wGX9Za9xi4k+HYPkz/Qido4l8OdAqmo0JanAQ16xGYAm4dd7M9n?=
 =?us-ascii?Q?EzUkoRhDs7Fi80m1Rh/GoLSoI1lv0KgLSvcqIeUbVb1Puo+jy/mBFCUbIf8U?=
 =?us-ascii?Q?0qVvt/00QTTdnQKO8z2WwEqCSaqIeLjob7/WFENmcOv6ohIeZXdcKVqiUU1u?=
 =?us-ascii?Q?igjHR1JFELNnMkueE9i2+whGF/P13ROR2Tctq6doGzgRiYWjAV5EFetUbUjQ?=
 =?us-ascii?Q?4VPDxTg5JIv084APa9XAD7tYghWDQm/W90FBjuOlrQAfJPXPBPBakNKF6BsN?=
 =?us-ascii?Q?N0YseVOhbMJp4Bcr6lmBgEeg3HuBs7B1E4t70bTIcSY4HVudjxozTNJetWIC?=
 =?us-ascii?Q?4JXAX8XdKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc58532-d8fd-4109-3b3d-08da1d2dd38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 09:13:08.5078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWvLHK9KwWd9Q7p+wQHa/4oJVJmRKo6sE2sJzv4TT8y1oP2YxIK9dxBWpM53EnnlilL7X3uFqBJAQkx/B2kYEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3480
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



> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Thursday, March 17, 2022 4:33 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; rdunlap@infradead.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar spac=
e.
>=20
>=20
>=20
> > -----Original Message-----
> > From: Wu, Hao <hao.wu@intel.com>
> > Sent: Thursday, March 17, 2022 4:18 PM
> > To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> > mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
> > linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; rdunlap@infradead.org
> > Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar sp=
ace.
> >
> > > > -----Original Message-----
> > > > From: Wu, Hao <hao.wu@intel.com>
> > > > Sent: Thursday, March 17, 2022 10:05 AM
> > > > To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> > > > mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
> > > > linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; rdunlap@infradead.org
> > > > Cc: corbet@lwn.net; Matthew Gerlach
> > > > <matthew.gerlach@linux.intel.com>
> > > > Subject: RE: [PATCH v6 1/6] fpga: dfl: Allow ports without local ba=
r space.
> > > >
> > > > > -----Original Message-----
> > > > > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > > > > Sent: Wednesday, March 16, 2022 3:08 PM
> > > > > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org;
> > > > > Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > > > > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > rdunlap@infradead.org
> > > > > Cc: corbet@lwn.net; Matthew Gerlach
> > > > > <matthew.gerlach@linux.intel.com>;
> > > > > Zhang, Tianfei <tianfei.zhang@intel.com>
> > > > > Subject: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar =
space.
> > > > >
> > > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > >
> > > > > In OFS, each PR slot (AFU) has one port device which include
> > > > > Port control, Port user clock control and Port errors. In legacy
> > > > > model, the AFU MMIO space was connected with Port device, so
> > > > > from port device point of view, there is a bar space associated w=
ith this
> port device.
> > > > > But in "Multiple VFs per PR slot" model, the AFU MMIO space was
> > > > > not connected with Port device. The BarID (3bits field) in
> > > > > PORTn_OFFSET register indicates which PCI bar space associated
> > > > > with this port device, the value 0b111 (FME_HDR_NO_PORT_BAR)
> > > > > means that no PCI bar for this port device.
> > > >
> > > > The commit message is not matching the change, it's not related to =
AFU...
> > > >
> > > > Current usage (FME DFL and PORT DFL are not linked together)
> > >
> > > This usage is only on Intel PAC N3000 and N5000 card.
> > > In my understand, the space of Port can put into any PCI bar space.
> > > In the previous use case, the space of port was located on Bar 2.
> > > For OFS, it allows the port without specific bar space.
> >
> > I didn't understand what you mean. Without your change, existing
> > driver supports Port in any BAR indicated by PORTn_OFFSET, it's fine
> > you put Port to BAR 0, or same BAR as FME. What do you mean by "port
> > without specific bar space"?
>=20
> "port with specific bar space" means that the port has a dedicated bar sp=
ace,
> including the DFL, AFU, this is use case in N3000/N5000 card.
>=20
> "port without specific bar space" means the port without specific bar spa=
ce, and
> the Port linked with FME for DFL perspective.
>=20
> >
> > >
> > > >
> > > > FME DFL
> > > > PORT DFL (located by FME's PORTn_OFFSET register, BAR + offset)
> > > >
> > > > Your proposed new usage is (FME DFL and PORT DFL are linked
> > > > together)
> > > >
> > > > FME DFL -> PORT DFL
> > > > So FME's PORTn_OFFSET can be marked, then driver could skip it.
> > > >
> > > > Is my understanding correct? If yes, please update your title and
> > > > commit message, and add some comments in code as well.
> > >
> > > From DLF perspective, I think it is yes.
> > >
> > > How about the title:  "fpga: dfl: Allow Port and FME's DFL link toget=
her" ?
> >
> > "Allow Port to be linked to FME's DFL" should be better, as we don't
> > encourage that people to connect FME DFL to Port DFL or any mixed order=
.
>=20
> Looks good.
>=20
> >
> > >
> > > I will also add some comments in code.
> > > Here is the new git commit for this patch, any comments?
> > >
> > > In previous FPGA platform like Intel PAC N3000 and N5000, The BarID
> > > (3bits field) in PORTn_OFFSET register indicated which PCI bar space
> > > was associated with this port device. In this case, the DFL of Port
> > > device was located in the specific PCI bar space, and then the FME
> > > and Port's DFL were not linked. But in OFS, we extend the usage, it
> > > allows the FME and Port's DFL  linked together when there was no
> > > local PCI bar space specified by the Port device. The value 0b111
> > > (FME_HDR_NO_PORT_BAR) of BarID means that no specific PCI bar space
> > > was associated with the port device.
> >
> > Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are
> > not connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack
> > device), PORT DFLs are connected to FME DFL directly, so we don't need
> > to search PORT DFLs via PORTn_OFFSET again. If BAR value of
> > PORTn_OFFSET is 0x7 (FME_PORT_OFST_BAR_SKIP/INVALID - depends the
> > description added to DFL
> > spec) then driver will skip searching the DFL for that port.
>

I like to split the patch to a sperate patch, so this patchset will divide =
into 2, one for port bar, one for VF creation.



