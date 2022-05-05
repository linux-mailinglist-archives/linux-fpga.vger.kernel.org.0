Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0F51BC4C
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 11:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240963AbiEEJkw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiEEJku (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 05:40:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B62B2B1BC;
        Thu,  5 May 2022 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651743431; x=1683279431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oKs7tNkFTFZVPHog4Wn90nF1EenyG22rUkEGQUSmnX4=;
  b=UZGJurWjSQk91CIR2jfyAE9VOrFAHAzgya8vwSEQwSt5aYWw1CZVs7LC
   Bgk8L6t9sXUN535WOBjyrKqMXxkmA4/dbnaAY8bOS7wVDOgZ/GavljGgj
   ZH077nuRtbCpKAqRZcTIKSXKNto5lXexf6RLUW717G95FoUK9MbrjTZS5
   gPaEXeRs7tpukGQ79/6eEA+bn2VaeHkTAzt6035nOi2MBhNM7jCzdEwu8
   M+YYD3JJV4EUsZts6DKoEk8wWN8OlNIGMKs+KLuo/qJzq/+Zh/nhf2Mgv
   kDXYsJGs4isQ7/F+AO+ASX/rMa1Rux6/gwJDRjm2JCoIVfAbVT0rWLcaK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="250041331"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="250041331"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="891257640"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2022 02:37:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 02:37:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 5 May 2022 02:37:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 5 May 2022 02:37:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 5 May 2022 02:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHoxzlc4MqetYZMDhagyTvkld1t1oX6V0ByJG2JYjC5sh4ahp3mtFturMsDRl9lhPryWE+65/pWUnRbTkzMHBQYLNfd3azQncoMuLwR74UMQB8oLPiDciDjRWWZiL/sI8bkOTkNvz3NkcDkUPdvFgprRnZyXEm/2zJTnxCF+fauz+td9eeQrr0twMCenZCJmXeDl+5ic/btc6MQIrgARgXvr0Chgd//01jc6b1rTOEyOKgbEf16aOpdt1AK/z/c02va/XzQ/1Omeb8Britl1OwFFk1JBcP/rDFAuH9+ojneER5MQBM9lHy718Z6T/nFZ6mBhEVWCh/dPuz+MLH6Naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw4eS7gdmcshmjZ1NfSTC9yV9RVrBdL7mcx0Vhw9jbg=;
 b=hkeKW8UrGBPkVu9Kg3Oiblrg2Z0CdgZDmluBFBjpoPTCXN76MOtX49Kl+XqueK+EQpMCms67UhNn6kiIcvrfFggTmFY8ZJYc5+Zopiy8H4mz2utVbirQ2kl8fakMozsAQlqC3iNrzn67+naHw3cQU1pCZ9Ug10BZvBL7/VbMSo5sNFEmR0W+1zBnCIKdULR3JCDfx4dwzl3ZHR2z8pNJdJycO+OBh6z/vWoF3KS/xW6kGXoMPwY3YPVI4n80udOeeZTLano72EASg7OD7IOlPIB5BUJe336anwiLlcQfNS+odWG85+YJ6aTWrge/qi4wsANRNZzXPehnI7mkSt7WsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by CY4PR11MB1688.namprd11.prod.outlook.com (2603:10b6:903:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 09:37:06 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%8]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 09:37:06 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Gerlach" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Thread-Topic: [PATCH v4] uio: dfl: add HSSI subsystem feature id
Thread-Index: AQHYYBXhq0QLvnormUiUUyimXrfATK0P1EuAgAAwaMA=
Date:   Thu, 5 May 2022 09:37:06 +0000
Message-ID: <BN9PR11MB54834743BD2A4C41B7385B9EE3C29@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220505001628.681226-1-tianfei.zhang@intel.com>
 <DM6PR11MB38197DBE27837090E0C9165985C29@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38197DBE27837090E0C9165985C29@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: b1381c82-c562-4213-3ab2-08da2e7ad1aa
x-ms-traffictypediagnostic: CY4PR11MB1688:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1688BADC8BDF27CCF9F44DF4E3C29@CY4PR11MB1688.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjH6tJIz7FxnxOLC0T6pP/KoVMgOgLd9Ib7XzT+NVZ65OxuHE6I43D2gF93znj25LeRR+657CSnrktyuSt5LL39z7hXlx41fzinA9acjpohg/hZJ0ONIZ+Qd8GnWqInLECmGKkMFG/NJlFxYd37jwtIVggdZYKn7mkuvjjwo9oKP59X9KCHielqyG5f824v3EFhLlRMtPosMWlvinDLB5/X0+8cegJd0AF0WYGIDbfi+es+fwSNTk9Hycatj2qpjrFfGnrDvKNE9pAZe2MUjow5zmSXsaoMSFmH4HVJC6DK4JHilmxPAHz3fZWZIan+RRmL7Fah5P/6E46CLgGyYXyaidPT0mANMqJKNs1LYQBgce8nFb9W3cBfGwfq5dzVwUlIP+gmq2u67dy+TAqqsprRifyGPjJqqzb0oupDubpvk897wZVZnpVgOz1v7YmCSFLcsS4FxuIi39snQNDDmyOe+0HpQH7rcgDFG7MKgHXfWCJs2Qoaow7m518h6AVRlnD8lxo5ecC3UeQAThqlaHRDegbt2J7m/0rAlm8/WMknf08l+ONhOy5gmVpg6zgkCUR+29YzB5shoJVH9i8bKu+JUVCRvTsjcZLHC5C1jL71/shppF2LYs4qsuvPp9DC7EgNeIl2IVLmekBUQhYOvGGbuTld7MIrYYDJjCpbMEuvSDZMrd4+hk6MD/lFGcP96R/nl0Vpgi3Vnw56cvckwWYUgQAKJLF94SHbhvOYcgcFzbYqX5MdT65DXPXQIkhqpF0WVZSg6l+s+IwIkeNJ3KfvIO7Kamaym1w+GlNbxyQ8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(55016003)(508600001)(316002)(4326008)(33656002)(66556008)(66476007)(8676002)(66446008)(64756008)(86362001)(76116006)(82960400001)(122000001)(52536014)(54906003)(71200400001)(38100700002)(66946007)(38070700005)(966005)(5660300002)(6506007)(7696005)(2906002)(53546011)(9686003)(83380400001)(26005)(186003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+d5hViMF4Qy60WfHdc/67L+cJJ0LSVaYm1DfR6FJV4fpSZwGkI9O7Tipsg20?=
 =?us-ascii?Q?0i7fJ/ImvCYDOpQoRDpj1WHbeAEp2ctBhxkcONLiPHUDNmrpcvxxP1nAOlCb?=
 =?us-ascii?Q?SVjVWa3OigHsnfWRL8v1hJRrGwgAViXJbiZcbJ8pJd/+XLqReu5Dbezsiu4/?=
 =?us-ascii?Q?pXJyz9anJJu7aPDmiNen4UoiHgjZkNwxRShtpQYMrOZbAav1D2D+2fta28eH?=
 =?us-ascii?Q?8RmWHqRcv90nUNzqS30+D2kTWMg5gjsH2bw1VsMexStM1R0gvedoBt5Oev8j?=
 =?us-ascii?Q?PEMVe8bYP6W0UgjtAUFQ6vaRevXA1IalFbiNVen3KTJZsnP9UJqwS9bAeV9t?=
 =?us-ascii?Q?ESOsvt8dLAW4yGdJJr9Ote7bZvLKb9roO/AH7b8AG23T3YT0qz5I7LtdAQvU?=
 =?us-ascii?Q?h28Zeyfc+PasIAcz41Ex1sdzFFfUP74KtAMU2VbojvCdo9W0jwYfRyvGbPQt?=
 =?us-ascii?Q?X/puesS5dA1gIndvkFlDwWDfks92qKtuLxBOkF03uUY//ZQ/RQcq7xt/oxDx?=
 =?us-ascii?Q?MSvBpAS4gMeuD18zBw0HCa/Di8Fhog6RbV2hXyWwgMWC/+5RkuB+dsXe/PfB?=
 =?us-ascii?Q?KCgeeRaYSm4lM0yuuP3PNsCjuQw+mJ4OxnUdFjIoouQJ84HETL7DXXvWsUVV?=
 =?us-ascii?Q?EP6g8gv9uHXaHhvsceHXXH7pvkvXwCZUd/TjCnWLIIAtE2fOTYtQDgfOXjpT?=
 =?us-ascii?Q?KYqi1xe7HU2Ysfh4xZdJa+CAZpT2Fxu3tGE9J3XH4/f8IdXwTnxk5fFxTyQo?=
 =?us-ascii?Q?OzxXVxzymNh0K75FePNj/lUcMjV90pVG0HS/LJCBChpGZUsl44KmBjwlCCSn?=
 =?us-ascii?Q?e1589+fXyVs7jiQ1Izr6T0GnENYMdjImBQO+Ye1Bm0HVxtgmsSZNsJ+N04p7?=
 =?us-ascii?Q?AAgDqMu1J/g/g4J8X+eg6N55pWCVZ68vT2TjfUUV9mqLg0hhMgJIXWvuroK/?=
 =?us-ascii?Q?Qv28IDjUBeo8/UBryex5Uj1Own5Y3yhIEiu6pp3IAk7Eaxbc2sFy4Nr/pWN5?=
 =?us-ascii?Q?lSBaYSwlkZ/PCAg2Kt0ispc2Zx6QeHZQpvLEhz9NL7mLSKedo/rPGHBxVqWL?=
 =?us-ascii?Q?fv22I43A/FlimJsSRuax4ActjYny+AwwhQmcf7REOCGEuqr+L9j0es8ezU33?=
 =?us-ascii?Q?FVILGzKUpuhSVbs9dFrt+9GP1/PSLXp8OBTjUz4RdG5lIE7QZdD6r1i4Wkut?=
 =?us-ascii?Q?Xq5749hfAvOGDKhDEfl0eqNO0t909ASQv+2T41fmR98J/Jeusn58MaE97+Sn?=
 =?us-ascii?Q?livBez3LEngdfCfH7G+tMupIGOnTMD1d3JHd1gxRZ1XAGTEUyncnk/H2Ir8U?=
 =?us-ascii?Q?hxxwewSJbIR9POWyUZQe91ldIQQyiCjg9Pchp1hwqjB9IM9dpvOrkVLNE4lI?=
 =?us-ascii?Q?b82AcEDb4FT2wfJF7U05VZPnymUiMkue8N1ChSnxM9yOkZErSPfFiqt3JFiU?=
 =?us-ascii?Q?gUpTk+3aHjJJdPclyv4BJPAOXb+j5u8HeNlHf2mfWAc/+/wKhH19G3wEDmBJ?=
 =?us-ascii?Q?YLfT7oqyjBLgJbpNZTR3qzo+f70rEfkM5PRFbGmCzSQna38txxjrNm0hgZVo?=
 =?us-ascii?Q?+7oLFsbSqLaGfN1tPv76v+dpX5Ge9CHV2ytzHjzEXWkKkeAaZj6ewewmROcv?=
 =?us-ascii?Q?nNnWjetFv9zfWr03m0plJth30qQCqtsRWkrASlI9kuvx0bK6O5o78XMWhmHM?=
 =?us-ascii?Q?Z8dk8H7yfE6OFgM5pDtmRxN1F5WbSXMCRgUjoWF//pS55daLS2W9NTw9LSJi?=
 =?us-ascii?Q?uBk5EkMNmQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1381c82-c562-4213-3ab2-08da2e7ad1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 09:37:06.4672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfSdUJf4YJXaIVA2my+W7adlFDh0kdfU/s2kPa3CMQ595vJYMFUBpK0RnCvxkZDXcweRTRv50KlJ5e8bgHXOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1688
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
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Thursday, May 5, 2022 2:35 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> gregkh@linuxfoundation.org
> Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v4] uio: dfl: add HSSI subsystem feature id
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Thursday, May 5, 2022 8:16 AM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > gregkh@linuxfoundation.org
> > Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
> > <tianfei.zhang@intel.com>
> > Subject: [PATCH v4] uio: dfl: add HSSI subsystem feature id
> >
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Add the Device Feature List (DFL) feature id for the High Speed Serial
> > Interface (HSSI) Subsystem to the table of ids supported by the
> > uio_dfl driver.
> >
> > The HSSI Subsystem is a configurable set of IP blocks to be used as
> > part of a Ethernet or PCS/FEC/PMA pipeline.
> > Like the Ethernet group used by the N3000 card, the HSSI Subsystem
> > does not fully implement a network device from a Linux netdev
> > perspective and is controlled and monitored from user space software
> > via the uio interface.
> >
> > The Feature ID table of DFL can be found:
> > https://github.com/OPAE/dfl-feature-id
>=20
> Is it possible to have multiple different HSSI implementations?
> Will they share the same feature id or not? If yes, why uses a generic na=
me
> here?

The HSSI subsystem is a new design, there will use for a long time.

>=20
> Is it possible someday this feature id is marked as legacy not used and i=
ntroduce
> a new one as the same name?

No, this HSSI subsystem is a standard device which  was designed for OFS.=20
It will extensively use for Intel FPGA PAC card in the feature.

>=20
> >
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> > v4: add Reviewed-by and Acked-by tag and add Feature ID table url in
> > git message.
> > v3: change the name of this feature id to HSSI_SUBSYS and rewrite
> >     the git message.
> > v2: add HSSI introduction and the git repo of Feature ID table.
> > ---
> >  drivers/uio/uio_dfl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c index
> > 89c0fc7b0cbc..8f39cc8bb034 100644
> > --- a/drivers/uio/uio_dfl.c
> > +++ b/drivers/uio/uio_dfl.c
> > @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> > }
> >
> >  #define FME_FEATURE_ID_ETH_GROUP	0x10
> > +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
> >
> >  static const struct dfl_device_id uio_dfl_ids[] =3D {
> >  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> > --
> > 2.26.2

