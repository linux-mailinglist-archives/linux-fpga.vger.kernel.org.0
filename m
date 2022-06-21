Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35D5528D3
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiFUA4f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 20:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFUA43 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 20:56:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4C114094;
        Mon, 20 Jun 2022 17:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655772985; x=1687308985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/mpxL9PtctV9UP32cT2kldNSCvVT3VH4TIUbrhdWGOM=;
  b=gSZfPo9W+op3S3pmd1z/ZeyPAnC3nQhMLjYZT6t9/PanEoGftB3QgOvh
   uzN8ANMz+FxkKp7B2OMxwKeoF9eM7N5Ew3VqYBTaVr3COBsNA17Gf/C44
   VhFguJD9ypqWDatogYrMSrkSU8pecM/e+zeuWH+CGhYVkjcKyiBi1CpvI
   wQ45Hqr+CHEiT3Qa9EK6lMeOtl8cP6FL5d0rWp2NqrpeEIJh75wFtlfhL
   KJyWQ2Qc4DL/jGvmmvqtQgd0TqLRIll8LEyKSxOseE9qJqrKlVEJDXxyz
   LFSpIJ6+deaZOKuDXv3ZEo2jQx4ianHUWloIakKDE0vode3Z7tJHO+fA5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263029245"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="263029245"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 17:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="689687848"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2022 17:56:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 17:56:23 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 20 Jun 2022 17:56:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 20 Jun 2022 17:56:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 20 Jun 2022 17:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izFD7tf2YNIvMpNtEmaRU8MxH60tGKJqK6xtHw4DJzmdS0CetUzqO+gulSC4/AwJvD08sB18pTKh+5bqxvF5ic+bZ/C5F4OvOkxwYYTVCUhMwDMxfVID5lTq76MSxaCbX9RQquLvKrAEPfSITDduH659Nq6zAH/cB6pQUcXLdlk66sqdTM/PIK+vRgILEvTyD/JU1vIp381sYlqMfhjUt+indSDBZTf/HEUy1o+zDQL4b3UKXgPxPXuDRm2hCBnqdYZUB65yku9Vif8GD8jC0JV09wnkus1Dp5BmutbvxGwvHPxGktxxWrJFg/MNOm148BTd6wuhfInn9zvVhAxr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q3eI67LFtWXSY+DzRAqlKmHEKQe40tXBPH9npgs7Ws=;
 b=mWNTJ0V4xKqGDXyvFeOVLiLDj3gevxDIRJKvw4x+ULJ3Ic6Ke1gsSI+X+CMKtvN1l65iVgHSMSqUdtPBTWw555OY8FeNJ8/CR4h/NWJhHyvNoEbnIx2uUaSdJx0per+EotqOqEAiB19DytiDKyPj2wunruYRMNFLG+tX9YdkowAIUsGirC9Io5LXneaRZK8OsqghAed70eoLwf0pGoegn2UMdRtzbo0W+zKii0Ewujxp8k3SD0TFdHOzlnAbahtJXB0ZHI9rOgyNOfepqsVwdzHTCCaOZUd4P1bWetSNQsU1r75fRBp+DGk+PI+kDKmC/5/PESA2rhjTLU7TtFGeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DM6PR11MB3241.namprd11.prod.outlook.com (2603:10b6:5:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 00:56:20 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::a113:c892:d94:dd10%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 00:56:20 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2 2/4] mfd: intel-m10-bmc: split into core and spi
Thread-Topic: [PATCH v2 2/4] mfd: intel-m10-bmc: split into core and spi
Thread-Index: AQHYge8N1rNxdEQKjUK7Uj3cFVMBIq1YFLoAgAD1anA=
Date:   Tue, 21 Jun 2022 00:56:20 +0000
Message-ID: <BN9PR11MB5483866E48A4182E2015D7A9E3B39@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220617020405.128352-1-tianfei.zhang@intel.com>
 <20220617020405.128352-3-tianfei.zhang@intel.com>
 <20220620095832.GB1319418@yilunxu-OptiPlex-7050>
In-Reply-To: <20220620095832.GB1319418@yilunxu-OptiPlex-7050>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a958b921-3ea9-4ee9-08f7-08da5320db0e
x-ms-traffictypediagnostic: DM6PR11MB3241:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB324160E11F142CBE4F08271AE3B39@DM6PR11MB3241.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hcxKHhogZEhtnXBDv7msCZ7KOoolImpDVk2OTdZCgKLzt1pU/25TCqu6pk+q2IIjsnXVrH5ctllwknEtqccLtiIwmiErdwemwSw4dIg1S8+2B+fybCNhPLPKWT9TfbhMqBM/FqpprX/+erN4NYymMooK4TQ5gCK5VQQ5xcmVSsFzmTtBA23yrF46G2SObCURnDNuGMbqb4O8bJbjAt/YcjeqKQAdmear/uzHsyE/i9ckmBOBg7u10xptwY/pNgZV7Hr3nVcOuNY21aBok3KTv0/uhMQH494TBoFvmCGoo+5TdrPgEhGBeISWv+ozpKqu0QzCwH7eO4YquzuwG8MaiBp4Pm6wSrZdSP9Ry8ASFQQDkLDt7r2qa2ZzsnR7JaK6EEANXrdzEUqKNeZmRmHDj7H+GUhO/AtIyxgif88ubTCzB74ZJ5/7+xO3PKdCNdOndDaUNWhXye3rfbWOXo0LwbxmE/RSHq5Go0ZYesIEUF5baRYmFbRnzjDcniHsEqjbIINCR47K5ZRMAlEIvh+7dGTVv/BfDy+R888qt90sP98S2yQIxVhQ/MkivVw2SlSYCjQ7td78/37x49Zq0Q0A+4K+an5TQnZJqFvZ5g4JUQjwT/81vCfShFHSZXerl7byRMRK0i+hccpCiUNiU1AHmfFIZg+bIcVV1uhTkT5K6DQYSSUQN0hEHKkLsdl0VFIxPSdaxWxrVOJadz80HwWtPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(396003)(346002)(39860400002)(83380400001)(8936002)(186003)(41300700001)(64756008)(66556008)(4326008)(6862004)(66946007)(9686003)(76116006)(8676002)(33656002)(66476007)(52536014)(6506007)(5660300002)(7696005)(53546011)(30864003)(86362001)(316002)(55016003)(478600001)(6636002)(2906002)(38100700002)(54906003)(66446008)(82960400001)(71200400001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ags0xFt6MmzRlIeuI7S8QT+LRGTY5o46Xy4cqVf3g9P+Vw9QLFIjGY6zHiJd?=
 =?us-ascii?Q?UPI38PCvTMwtkpdphPKEG3Qa1xAoVAOXYYa9dr027G0fy6oCK9FQgv8CVNVY?=
 =?us-ascii?Q?rgdRb3rCnukfFh0inClkL+prgKQvJaTaNJmtcMg8Knnu8DLzGN1c0iA/6rRI?=
 =?us-ascii?Q?1aftU1Si1k4NWRmNxIDa+Ny8FApuTRDAkyvXkTyRD3AfQNS9LH4Ax+n17cLt?=
 =?us-ascii?Q?v7E1QyDipKb2M9lNhe1To8IdfJ3tZaM1LKeM8aTJsvu0iXL8Jk84K4zZs9wy?=
 =?us-ascii?Q?bi+u9bRI3KE749i0JJxV0sWGkdQ8abAGisvTrpGN6J4F+YcPPIebBVAjWv/d?=
 =?us-ascii?Q?yjdmwXR0HqEuLLLU+Ch28Pf8QfV6hE40iEFiY+zTyD/tftuCFk8wJzt6AnBC?=
 =?us-ascii?Q?zl7WiR8Hhpn/0kTdc402X0w+ppOT/QKjlqeAGKatA9S9eQrtRu0F9T6QdFAE?=
 =?us-ascii?Q?IUWghY4N9+xsvLsDMz9tZFM1g6HsGrwx1k1YXbzq++YXqlzrmh9TKGCvzbaA?=
 =?us-ascii?Q?FPcUK1phCA1D1js02Zmefa6TVKBSEnsgIKHZajXNZKIT8iywDrrwzo8fD1X6?=
 =?us-ascii?Q?ZG5ZVICIAjf+N8nUXdLk6Fq339BqP1RL8InWT1I9vHnzLuABfEz56AjLA19T?=
 =?us-ascii?Q?BzXYAT/l+zpA8cO6IbkBuedVo28s9alBR4k0whlZZT+zw9bpuAHj1LQJCJMA?=
 =?us-ascii?Q?4A/+Uo7k3igxNqUoF4/GJvjV2mGKftUNszrF+e7FAF1NUYNwskM7tyYmgkcb?=
 =?us-ascii?Q?fc3z6vOdmbncyjNWDd566CMX/FyrxH+ntZHtYzd3jhqzXyC7TWtC9LcPkqoZ?=
 =?us-ascii?Q?k8rHSm6gafjjAd6jwu1QqyCDmzQL82dGv7gWIr7wOUcfWey+7RdWrR/QjSC3?=
 =?us-ascii?Q?N1gsKuvzqUZyAQuw4gLHHMNCiblXdM2YDyXBX2/s9FZtl71hmIDKTrsUxR1Z?=
 =?us-ascii?Q?z/r5Ugu7RgoZsY4WBSdBuM7a9Cv3uUyoC+X6HSzP75Ko4f3yTcdZPennYBqd?=
 =?us-ascii?Q?J8t18DGZq1IJQHlW9Y69jdNmlsmnO1T2TbHf5EpXWtQp2kSbikbI7fmhEL/v?=
 =?us-ascii?Q?a7nu+Og1BkuSqm2z6uXfkA1W3CDuAbyKHA66/nKHzFOsJuGzOXnqtgqsKKGS?=
 =?us-ascii?Q?mdAmaOgTvMXmfiiZpjZEAtfuMhBBD4NuIYvRwy4Oqr5roUvVmnzehHosvlnZ?=
 =?us-ascii?Q?TL5WMgcjK+fiaERiPwnLVJC2Yecgga12HrC1cBdZIG4YEsCRU2u51Jr99qJG?=
 =?us-ascii?Q?UYnEu0G0DTe2Vl+0iSrJfJeihT1CWaqBkLrkCtz0khaswzmvJhAFQZqmgLt5?=
 =?us-ascii?Q?Zh7rE7BG6/UczuwN1jL/zLyCeug4esA+W4d2w/EO/BaiYZ2B2g5wMbY+a6KQ?=
 =?us-ascii?Q?DsJROI3Ow/SfN+BIokTfA0xGrvF7gzFZ+mzbNN2sBUE/eY0AzXhQXtVCj0fE?=
 =?us-ascii?Q?1WomMRuCtQnTazeC/lzBk+6EYMLwQRMG3qffUuRCdk9MgVmxaGV3yMf8WV6B?=
 =?us-ascii?Q?b/aGgST2FdMgZlaKhm8BHpWoIwzzn0c3hox4UxgLqxNDWhhlhRiHAUNp4Ojh?=
 =?us-ascii?Q?/q856S7C00Ip19KY+X/Qb9B6XKL5B4XrRFEW2CQ0lDjlRu8LcY0pJGNWBKBJ?=
 =?us-ascii?Q?pSsa7g9SYaT5mvUTlcmfTuZf01JaqlZ7+ZRG3YASl8g+KT/JV4wL98ObOnrT?=
 =?us-ascii?Q?nOs/dBo0TrVqqZ23g4ryFpI7n2wazmrmOszDqJbo0hOfqCG8lezi3Ar0Tydz?=
 =?us-ascii?Q?IWf+oOFiT95ii7l+1kEZjUNEo22sn/2b37kGHL/ACysoKrY3cCQAncQJ2t4Y?=
x-ms-exchange-antispam-messagedata-1: mVJwzd2+WNrLEg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a958b921-3ea9-4ee9-08f7-08da5320db0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 00:56:20.5223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjzZS9bv25essr7dH16C8ctguinvPqc9tksZ6OV2r4DJ3Gl1L5VHRTZobeeouidEi8HogT0ACGIsJ3NMyXLmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Monday, June 20, 2022 5:59 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>
> Cc: lee.jones@linaro.org; Wu, Hao <hao.wu@intel.com>; trix@redhat.com;
> linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org; Weight, Russell=
 H
> <russell.h.weight@intel.com>; matthew.gerlach@linux.intel.com
> Subject: Re: [PATCH v2 2/4] mfd: intel-m10-bmc: split into core and spi
>=20
> On Thu, Jun 16, 2022 at 10:04:03PM -0400, Tianfei Zhang wrote:
> > Split the common code from intel-m10-bmc driver into intel-m10-bmc-core=
.
> > intel-m10-bmc-core is the core MFD functions which can support
> > multiple bus interfaces like SPI bus.
>=20
> Please specify which else are you going to support, for better understand=
ing.

There are lots of common code for intel-m10-bmc-spi and intel-m10-bmc-pmci =
driver.
To better support multiple bus interfaces and  reduce  the duplicate code ,=
=20
we like to split the common code into a core file.

>=20
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/mfd/Kconfig                           |  30 +++---
> >  drivers/mfd/Makefile                          |   5 +-
> >  .../{intel-m10-bmc.c =3D> intel-m10-bmc-core.c} | 101 +++++-----------=
--
> >  drivers/mfd/intel-m10-bmc-spi.c               |  83 ++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h             |  15 +++
> >  5 files changed, 144 insertions(+), 90 deletions(-)  rename
> > drivers/mfd/{intel-m10-bmc.c =3D> intel-m10-bmc-core.c} (63%)  create
> > mode 100644 drivers/mfd/intel-m10-bmc-spi.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> > 3b59456f5545..ee8398b02321 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2158,18 +2158,24 @@ config SGI_MFD_IOC3
> >  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
> >  	  then say Y. Otherwise say N.
> >
> > -config MFD_INTEL_M10_BMC
> > -	tristate "Intel MAX 10 Board Management Controller"
> > -	depends on SPI_MASTER
> > -	select REGMAP_SPI_AVMM
> > -	select MFD_CORE
> > -	help
> > -	  Support for the Intel MAX 10 board management controller using the
> > -	  SPI interface.
> > -
> > -	  This driver provides common support for accessing the device,
> > -	  additional drivers must be enabled in order to use the functionalit=
y
> > -	  of the device.
> > +config MFD_INTEL_M10_BMC_CORE
> > +        tristate
> > +        select MFD_CORE
> > +        select REGMAP
> > +        default n
> > +
> > +config MFD_INTEL_M10_BMC_SPI
> > +        tristate "Intel MAX 10 Board Management Controller with SPI"
> > +        depends on SPI_MASTER
> > +        select MFD_INTEL_M10_BMC_CORE
> > +        select REGMAP_SPI_AVMM
> > +        help
> > +          Support for the Intel MAX 10 board management controller usi=
ng the
> > +          SPI interface.
> > +
> > +          This driver provides common support for accessing the
> > + device,
>=20
>                                                                    device=
 by SPI,

I  will fix it on next version patch.
>=20
> > +          additional drivers must be enabled in order to use the funct=
ionality
> > +          of the device.
> >
> >  config MFD_RSMU_I2C
> >  	tristate "Renesas Synchronization Management Unit with I2C"
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile index
> > 858cacf659d6..b5d3263c1205 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -266,7 +266,10 @@ obj-$(CONFIG_MFD_QCOM_PM8008)	+=3D qcom-
> pm8008.o
> >
> >  obj-$(CONFIG_SGI_MFD_IOC3)	+=3D ioc3.o
> >  obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+=3D simple-mfd-i2c.o
> > -obj-$(CONFIG_MFD_INTEL_M10_BMC)   +=3D intel-m10-bmc.o
> > +
> > +intel-m10-bmc-objs             :=3D intel-m10-bmc-core.o
> > +obj-$(CONFIG_MFD_INTEL_M10_BMC_CORE)   +=3D intel-m10-bmc.o
>=20
> Why make a intel-m10-bmc obj here? What's the problem of intel-m10-bmc-
> core.o?

This intel-m10-bmc-objs is for CONFIG_MFD_INTEL_M10_BMC_CORE.
So if want to support intel-m10-bmc-spi driver, it should set both CONFIG_M=
FD_INTEL_M10_BMC_CORE
and CONFIG_MFD_INTEL_M10_BMC_SPI in .config file.

Here is another example in drivers/mfd/Makefile.

intel-soc-pmic-objs             :=3D intel_soc_pmic_core.o intel_soc_pmic_c=
rc.o
obj-$(CONFIG_INTEL_SOC_PMIC)    +=3D intel-soc-pmic.o
obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)      +=3D intel_soc_pmic_bxtwc.o

>=20
> > +obj-$(CONFIG_MFD_INTEL_M10_BMC_SPI)   +=3D intel-m10-bmc-spi.o
> >
> >  obj-$(CONFIG_MFD_ATC260X)	+=3D atc260x-core.o
> >  obj-$(CONFIG_MFD_ATC260X_I2C)	+=3D atc260x-i2c.o
> > diff --git a/drivers/mfd/intel-m10-bmc.c
> > b/drivers/mfd/intel-m10-bmc-core.c
> > similarity index 63%
> > rename from drivers/mfd/intel-m10-bmc.c rename to
> > drivers/mfd/intel-m10-bmc-core.c index 7e521df29c72..f6dc549e1bc3
> > 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc-core.c
> > @@ -1,23 +1,14 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Intel MAX 10 Board Management Controller chip
> > + * Intel MAX 10 Board Management Controller chip - common code
> >   *
> > - * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
> > + * Copyright (C) 2018-2022 Intel Corporation. All rights reserved.
> >   */
> >  #include <linux/bitfield.h>
> >  #include <linux/init.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/mfd/intel-m10-bmc.h>
> >  #include <linux/module.h>
> > -#include <linux/mutex.h>
> > -#include <linux/regmap.h>
> > -#include <linux/spi/spi.h>
> > -
> > -enum m10bmc_type {
> > -	M10_N3000,
> > -	M10_D5005,
> > -	M10_N5010,
> > -};
> >
> >  static struct mfd_cell m10bmc_d5005_subdevs[] =3D {
> >  	{ .name =3D "d5005bmc-hwmon" },
> > @@ -33,26 +24,6 @@ static struct mfd_cell m10bmc_n5010_subdevs[] =3D {
> >  	{ .name =3D "n5010bmc-hwmon" },
> >  };
> >
> > -static const struct regmap_range m10bmc_regmap_range[] =3D {
> > -	regmap_reg_range(M10BMC_LEGACY_BUILD_VER,
> M10BMC_LEGACY_BUILD_VER),
> > -	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> > -	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END),
> > -};
> > -
> > -static const struct regmap_access_table m10bmc_access_table =3D {
> > -	.yes_ranges	=3D m10bmc_regmap_range,
> > -	.n_yes_ranges	=3D ARRAY_SIZE(m10bmc_regmap_range),
> > -};
> > -
> > -static struct regmap_config intel_m10bmc_regmap_config =3D {
> > -	.reg_bits =3D 32,
> > -	.val_bits =3D 32,
> > -	.reg_stride =3D 4,
> > -	.wr_table =3D &m10bmc_access_table,
> > -	.rd_table =3D &m10bmc_access_table,
> > -	.max_register =3D M10BMC_MEM_END,
> > -};
>=20
> Why remove all these configurations, I suppose it is not related to bus t=
ype.

This intel_m10bmc_regmap_config has removed to intel-m10-bmc-spi driver, it=
 is related to SPI bus.

>=20
> > -
> >  static ssize_t bmc_version_show(struct device *dev,
> >  				struct device_attribute *attr, char *buf)  { @@
> -131,7 +102,16 @@
> > static struct attribute *m10bmc_attrs[] =3D {
> >  	&dev_attr_mac_count.attr,
> >  	NULL,
> >  };
> > -ATTRIBUTE_GROUPS(m10bmc);
> > +
> > +static const struct attribute_group m10bmc_group =3D {
> > +	.attrs =3D m10bmc_attrs,
> > +};
> > +
> > +const struct attribute_group *m10bmc_dev_groups[] =3D {
> > +	&m10bmc_group,
> > +	NULL,
> > +};
> > +EXPORT_SYMBOL_GPL(m10bmc_dev_groups);
> >
> >  static int check_m10bmc_version(struct intel_m10bmc *ddata)  { @@
> > -158,37 +138,21 @@ static int check_m10bmc_version(struct intel_m10bmc
> *ddata)
> >  	return 0;
> >  }
> >
> > -static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> > +int m10bmc_dev_init(struct intel_m10bmc *m10bmc)
> >  {
> > -	const struct spi_device_id *id =3D spi_get_device_id(spi);
> > -	struct device *dev =3D &spi->dev;
> > +	enum m10bmc_type type =3D m10bmc->type;
> >  	struct mfd_cell *cells;
> > -	struct intel_m10bmc *ddata;
> >  	int ret, n_cell;
> >
> > -	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > -	if (!ddata)
> > -		return -ENOMEM;
> > -
> > -	ddata->dev =3D dev;
> > -
> > -	ddata->regmap =3D
> > -		devm_regmap_init_spi_avmm(spi,
> &intel_m10bmc_regmap_config);
> > -	if (IS_ERR(ddata->regmap)) {
> > -		ret =3D PTR_ERR(ddata->regmap);
> > -		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> > -	spi_set_drvdata(spi, ddata);
> > +	dev_set_drvdata(m10bmc->dev, m10bmc);
>=20
> The naming is not consistent here, some are ddata, some are m10bmc, pleas=
e
> keep a unified name acress all the patches.

I agree, I will fix it.

>=20
> >
> > -	ret =3D check_m10bmc_version(ddata);
> > +	ret =3D check_m10bmc_version(m10bmc);
> >  	if (ret) {
> > -		dev_err(dev, "Failed to identify m10bmc hardware\n");
> > +		dev_err(m10bmc->dev, "Failed to identify m10bmc
> hardware\n");
>=20
> Keep the dev local variable so that we don't have to change every related=
 lines.

I agree, I will fix it.

>=20
> >  		return ret;
> >  	}
> >
> > -	switch (id->driver_data) {
> > +	switch (type) {
> >  	case M10_N3000:
> >  		cells =3D m10bmc_pacn3000_subdevs;
> >  		n_cell =3D ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> > @@ -205,33 +169,16 @@ static int intel_m10_bmc_spi_probe(struct
> spi_device *spi)
> >  		return -ENODEV;
> >  	}
> >
> > -	ret =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells,
> n_cell,
> > -				   NULL, 0, NULL);
> > +	ret =3D devm_mfd_add_devices(m10bmc->dev, PLATFORM_DEVID_AUTO,
> > +				   cells, n_cell, NULL, 0, NULL);
>=20
> ditto
>=20
> >  	if (ret)
> > -		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> > +		dev_err(m10bmc->dev, "Failed to register sub-devices: %d\n",
> > +			ret);
>=20
> ditto
>=20
> >
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(m10bmc_dev_init);
> >
> > -static const struct spi_device_id m10bmc_spi_id[] =3D {
> > -	{ "m10-n3000", M10_N3000 },
> > -	{ "m10-d5005", M10_D5005 },
> > -	{ "m10-n5010", M10_N5010 },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> > -
> > -static struct spi_driver intel_m10bmc_spi_driver =3D {
> > -	.driver =3D {
> > -		.name =3D "intel-m10-bmc",
> > -		.dev_groups =3D m10bmc_groups,
> > -	},
> > -	.probe =3D intel_m10_bmc_spi_probe,
> > -	.id_table =3D m10bmc_spi_id,
> > -};
> > -module_spi_driver(intel_m10bmc_spi_driver);
> > -
> > -MODULE_DESCRIPTION("Intel MAX 10 BMC Device Driver");
> > +MODULE_DESCRIPTION("Intel MAX 10 BMC core MFD driver");
> >  MODULE_AUTHOR("Intel Corporation");
> >  MODULE_LICENSE("GPL v2");
> > -MODULE_ALIAS("spi:intel-m10-bmc");
> > diff --git a/drivers/mfd/intel-m10-bmc-spi.c
> > b/drivers/mfd/intel-m10-bmc-spi.c new file mode 100644 index
> > 000000000000..9cafbc0f89f0
> > --- /dev/null
> > +++ b/drivers/mfd/intel-m10-bmc-spi.c
> > @@ -0,0 +1,83 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel MAX 10 Board Management Controller chip
>=20
> SPI driver for Intel MAX 10 ...

This is good for me.

>=20
> > + *
> > + * Copyright (C) 2018-2021 Intel Corporation. All rights reserved.
> > + */
> > +#include <linux/bitfield.h>
> > +#include <linux/init.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/intel-m10-bmc.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +
> > +static const struct regmap_range m10bmc_regmap_range[] =3D {
> > +	regmap_reg_range(M10BMC_LEGACY_BUILD_VER,
> M10BMC_LEGACY_BUILD_VER),
> > +	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> > +	regmap_reg_range(M10BMC_FLASH_BASE, M10BMC_FLASH_END), };
> > +
> > +static const struct regmap_access_table m10bmc_access_table =3D {
> > +	.yes_ranges	=3D m10bmc_regmap_range,
> > +	.n_yes_ranges	=3D ARRAY_SIZE(m10bmc_regmap_range),
> > +};
> > +
> > +static struct regmap_config intel_m10bmc_regmap_config =3D {
> > +	.reg_bits =3D 32,
> > +	.val_bits =3D 32,
> > +	.reg_stride =3D 4,
> > +	.wr_table =3D &m10bmc_access_table,
> > +	.rd_table =3D &m10bmc_access_table,
> > +	.max_register =3D M10BMC_MEM_END,
> > +};
> > +
> > +static int intel_m10_bmc_spi_probe(struct spi_device *spi) {
> > +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> > +	struct device *dev =3D &spi->dev;
> > +	struct intel_m10bmc *ddata;
> > +	int ret;
> > +
> > +	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > +	if (!ddata)
> > +		return -ENOMEM;
> > +
> > +	ddata->dev =3D dev;
> > +	ddata->type =3D (enum m10bmc_type)(id->driver_data);
> > +
> > +	ddata->regmap =3D
> > +		devm_regmap_init_spi_avmm(spi,
> &intel_m10bmc_regmap_config);
> > +	if (IS_ERR(ddata->regmap)) {
> > +		ret =3D PTR_ERR(ddata->regmap);
> > +		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	spi_set_drvdata(spi, ddata);
>=20
> Why we need this? I saw the dev.drvdata is set in core driver.

I agree, it is duplicate, we can remove it.

>=20
> > +
> > +	return m10bmc_dev_init(ddata);
> > +}
> > +
> > +static const struct spi_device_id m10bmc_spi_id[] =3D {
> > +	{ "m10-n3000", M10_N3000 },
> > +	{ "m10-d5005", M10_D5005 },
> > +	{ "m10-n5010", M10_N5010 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> > +
> > +static struct spi_driver intel_m10bmc_spi_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "intel-m10-bmc",
>=20
> Need renaming?

How about "intel-m10-bmc-spi"?

>=20
> > +		.dev_groups =3D m10bmc_dev_groups,
> > +	},
> > +	.probe =3D intel_m10_bmc_spi_probe,
> > +	.id_table =3D m10bmc_spi_id,
> > +};
> > +module_spi_driver(intel_m10bmc_spi_driver);
> > +
> > +MODULE_DESCRIPTION("Intel MAX 10 BMC SPI bus interface");
> > +MODULE_AUTHOR("Intel Corporation"); MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("spi:intel-m10-bmc");
> > diff --git a/include/linux/mfd/intel-m10-bmc.h
> > b/include/linux/mfd/intel-m10-bmc.h
> > index f0044b14136e..dd81ffdcf168 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -118,14 +118,23 @@
> >  /* Address of 4KB inverted bit vector containing staging area FLASH co=
unt */
> >  #define STAGING_FLASH_COUNT	0x17ffb000
> >
> > +/* Supported MAX10 BMC types */
>=20
> Please use correct format for kernel doc comments

I will fix it on next version patch.

>=20
> > +enum m10bmc_type {
> > +	M10_N3000,
> > +	M10_D5005,
> > +	M10_N5010,
> > +};
> > +
> >  /**
> >   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
> >   * @dev: this device
> >   * @regmap: the regmap used to access registers by m10bmc itself
> > + * @type: the type of MAX10 BMC
> >   */
> >  struct intel_m10bmc {
> >  	struct device *dev;
> >  	struct regmap *regmap;
> > +	enum m10bmc_type type;
> >  };
> >
> >  /*
> > @@ -159,4 +168,10 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc,
> > unsigned int addr,  #define m10bmc_sys_read(m10bmc, offset, val) \
> >  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> >
> > +/*
> > + * MAX10 BMC Core support
> > + */
> > +int m10bmc_dev_init(struct intel_m10bmc *m10bmc); extern const struct
> > +attribute_group *m10bmc_dev_groups[];
> > +
> >  #endif /* __MFD_INTEL_M10_BMC_H */
> > --
> > 2.26.2
