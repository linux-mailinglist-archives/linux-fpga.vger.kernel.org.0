Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FE94BD724
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 08:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiBUHkH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 02:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiBUHkG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 02:40:06 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077701084;
        Sun, 20 Feb 2022 23:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645429183; x=1676965183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bzoYNif+b1W+xFthj20FSOORhXzKvkFRtxMfCCTz0vY=;
  b=oCfx4g0eh/bEZKyhts4NfrPrr/lQfk1f0ICglPi864Ren+xNmeBhj+su
   5EsCtJLFpw3pcJgcwUhAlSQoigQM6j0i1AZ3J2o8b24giLen7QY7FTI5b
   gMxTkqPU7+M7X9wlExHtBJEw0bc+8wGwFKq+9+fwtQPI1a0AQkK6NjniD
   NdJ2ZIujEVdXbnY1S5scIG6749KPNxPc1DvQZvwXiBmjZY3PEY3A20ut4
   jv60KrVSy8BxjkQEH1M4wqFmI29IVl7mTkwKCUL3Euwf9ErZ4b90sPvH7
   opjSKppjgmwsvWUmuzfy0EnNsrW5xsBCbZZCtmBHx8FyUZ5YwZVZKfYUk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="314718395"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="314718395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:39:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="547226327"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2022 23:39:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 23:39:40 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 23:39:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 20 Feb 2022 23:39:40 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 20 Feb 2022 23:39:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWcI1AicAwn0L2Esr98ukFEX83wgQqbHEQn7W1hTSPZtKhiWtE1o8sDRIRp0wO3le0jp8UVgK6zuOveP5B0dN/MFZWPuKwASbOse8XYAa0SobrB2uKTwLjs4d6qYIueeagmgLmcXqffRTBPQHv4ljuSDwqzKlYqyYVmU2/2afbrqmhPVMkoG1cwzWQDOaGfVBuRjJiyB+nmFmId6OaOTDTsOcpkB89prHGEZrGNx6gBo/fLCny0SPNWFD9f0Y0sAfSvo91Mcj/VTuzrueg+3rTUxCf1tj/dQYrtX88k5zxrkapexF7gsSirHxGkOGie9WwyQmN+553W8AbW7sJ+Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhCrpT8ZhdI45NYybrTnvAKXtyXM0kdh3KHwJ5QTteY=;
 b=WpyAN7nEQ3mNw7cAJEUrfkCHR72eG664G6Hwxm/vwV3GDcOF4nKEKGzYuboaQMYcYei7XM3RKJCoYfUgr1LDwKipSiVHzUifXn4PEi8uhMceyZAbTltMs8mtu1lt5awEsAJxy9LLRfTuYu5zkc2X/4d4TLtOxC26AdW0bsuvp+QZ+WsJj/jvMxXQ4mTgVebO2MzWv6oUB076utZUb4GbCV338FlUu9RxhkkeZo9uJCHrpb/izfS7dHMQ4uT6iP2zMa/0LxQsdKV+vC9VjqQvDV28+YsmIbdCrtUb+gKhIfIY98+RGHEotguUODftAMBJtakIwOOMddXtDoUzjiNYfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MN2PR11MB4255.namprd11.prod.outlook.com (2603:10b6:208:18a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Mon, 21 Feb
 2022 07:39:36 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 07:39:36 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Thread-Topic: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
Thread-Index: AQHYIZYrI9khWBzXDEChcSjUIMBh1qyViSyAgAgTbdA=
Date:   Mon, 21 Feb 2022 07:39:35 +0000
Message-ID: <BN9PR11MB54830141CECE8076A7EBB1D9E33A9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-2-tianfei.zhang@intel.com>
 <DM6PR11MB381933DF77F512D7E70539EF85359@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB381933DF77F512D7E70539EF85359@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: c9cc3256-d4ba-43ee-6c41-08d9f50d4f62
x-ms-traffictypediagnostic: MN2PR11MB4255:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB425584255AC13F9159281309E33A9@MN2PR11MB4255.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6ZYdiF9dKXhHp7zo1Uj6xGjxzIK1KzbhBMkkwFoJ3hLTf61/2Jp72xpVDrpFXV2NUBryUFyYGtlpujYsSs/3rMeMpC2KfZmF2A5WAzJcwzY3oAn0PJpwQoHfxn6d7WXuqXIkSy7fXw1kWHy6RrGixjluIG70w2yzrcpv8nmFoTIrssiSpq/woX/13bd2+M5JsUODqAVUKYzCmQtUAemz/KXqjO7x+pD4qeN+RjAqHtf3t6trMaMIEiFbdQFDeX2kmyGEOtxPnG5FWqLVAwQPmkq6nb7xHDZOxWAoBy0o6su1AeVZkmxUCMe5pXu9/HiQMgPO9K1DxFvStziFWfy4PkVHKCnPZ2GCmEVU8NPaQbPzqb97IY3VjhbtTyrcmHa+hkR4VGdG4vWC896tHSzhP+XbsySeoKNtsSwQxyR0dsLPaq6eaNTW8ycnbhKvDWsTlk2VYQGVgwd+PFQ6qqFQdGsFuzhjn3WpSLbNWNdkQE71IEvqZOb3FFE64ifuVSeGJGWK1Qnaei8W+pOGk4lYVw2ofCS9Ii/m07c7loqKRtSan4IsNaglWGGuVeXl9VJcJgDcBGAKfJMeSU5fiBkYzBrDs/+7QjSaL8N68R9H5NZaefxHrz7Enxqj3xWpKr1k5fg8Or6Jp4rxsCpVCgVbXwVhUAtYINH3eg2txOgMoZ7UUxXRXr9tkAYLXb++0C0L7UOabrPl2aXl8CD1EEhQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66476007)(66556008)(66946007)(76116006)(66446008)(64756008)(316002)(508600001)(55016003)(110136005)(83380400001)(33656002)(30864003)(9686003)(8936002)(5660300002)(52536014)(2906002)(38070700005)(82960400001)(122000001)(71200400001)(26005)(53546011)(6506007)(7696005)(86362001)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?meZrNuuQSklTirJW5Amzjgzyiw1FmCwAXRmxLj/G2PO2rjK+W12bdyyiqcuD?=
 =?us-ascii?Q?aAs08VI7ma3UqLk9BOE8CK2Ki+VeB8rKBDH4LTrgEfJ8Zhr8axH6AC2URlcH?=
 =?us-ascii?Q?Dwm7qL5SG2cXHOKp+jJn8HAdEUCyVRvBXYHQMOGgh//7EBbFq2zI8rRmLAZk?=
 =?us-ascii?Q?xCQodJigYi0qA9X4Ch1wouaHKj/iRCJAEJG0NpOukWnUBMdxLLdLBekTUAgs?=
 =?us-ascii?Q?maANxaakb4NI+2Fy+20C0393Uy7ODDSH26Bcf8hhI463Z7a+NQRxmP20eFc0?=
 =?us-ascii?Q?6FZCvTzqDyqYyISMrY+pznCTfcB8Grp76oMr/wK4o2bwkns4FntwNDFJM//Y?=
 =?us-ascii?Q?QBaPyBtOESlfj4B64KNvb5CEv2Mj6hLgzXGgtLsG9DWCAAYoudX4nB1/5BMk?=
 =?us-ascii?Q?am+SWP6trdE2IbUJJZ+KRWjzj1NTUOFjZDuEMdYzLDxzoI1NPngyZ581hEvL?=
 =?us-ascii?Q?kWXi6VoTQeTX1g3mOraaEPtlsYP0BNexGPkbOWRx1fmxW/9bdinWiezSE/we?=
 =?us-ascii?Q?616OdKb84Rn01BILPywpFg6BNCuQb2mSdP1FWaMoFxopbXqxxqAkK54mBYB3?=
 =?us-ascii?Q?cI7s3XOf8OfZb9hKCPMzMCFw3CXahEQ4A12AVmR4WvIUsKmdmjR7bIFcnVDI?=
 =?us-ascii?Q?q11zLSrQpoxUdaUM7aUlutHiIIufJxIIQhwmm/moJhhb2VliBLc9+D8KxnY+?=
 =?us-ascii?Q?a3xPFTmvPYMcsAPRowLgU/rPPsDnk6sMe3J1St3pnpnb2BZNmnwYR2IfzKWl?=
 =?us-ascii?Q?0Zl3pKUK4StIo9PnEzAkZocJyZQ+/U8UxL3iwZmBWU/GExo12uzqtZHE1JjI?=
 =?us-ascii?Q?15Ec6yyHfrkOA0zJeu4r76GT8MX8L/w/nx7SOs0uQAaYrr3j1OFjhXzIjV73?=
 =?us-ascii?Q?151jWdV9D2o9yRyI+JnLA45IB906E2sW61/a0YtKlcZr/1/titv2KJGOsLeG?=
 =?us-ascii?Q?XMm8FvNSWxk6n4I4TmY3PnIDlBCCisNdPGFVtkTPxRjcfMe99TE7DEunkG62?=
 =?us-ascii?Q?gDfh4NdLKl96YJ5ZCA92++IwCQhXktM51Lu09A6vj8w8C8RHAxi6GahtOWdD?=
 =?us-ascii?Q?MDWmpVybSXmNW+QmWocmX2JREqvmEHC8hYNdLdmg63PiKAicmXoBHq4Hx1FM?=
 =?us-ascii?Q?mGwvSkQSUbXfqzzFucgwzbSdP5LoR3BQ9MiiRFaz89a4goDDI+grLlfl2/vJ?=
 =?us-ascii?Q?DlH4LGLpn8vYESHe5/ORmFj1f9Y7eckrXaOnSVOUq6s4t2sjgiPHZwXN2+e9?=
 =?us-ascii?Q?ZgD8Zr6YS7InPg9ARbD9g2ZK/QOzNoEMXJBloccDHbie9n60sbhG37io+l9f?=
 =?us-ascii?Q?afiEYPlIIzgR7n4etMamGr6yB0F8FhYWkBYltpKX8+okk538SvawbX4tZd4n?=
 =?us-ascii?Q?6blEv1CuwPG5y3LJayFUyqu7Mit1CnjlLCtfm9EERJdeLZO29VEOIYCHVxQN?=
 =?us-ascii?Q?NxHg0yatc4wwk/cfu6mtHkxg9f4ELJoiTmuZd8iB8my6VwkxzK2M7lJoiX+1?=
 =?us-ascii?Q?hu/L3PzIz4ofrs+wgpe9XgcFEnG8kpDC75tWtj9n8lLf1b8gMNHFLYNS+MNd?=
 =?us-ascii?Q?rLong22dOa9Zr5c6F4q0D3nztx/Lh3t4jHozza1OTR5NrBmV/RShcdBLyshK?=
 =?us-ascii?Q?0L25g+1w/RnE/jGruZVWghI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cc3256-d4ba-43ee-6c41-08d9f50d4f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:39:35.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNYxSkvN2DdxD73SPCHG0Pmg/5XUhHm3jEPEbNtiLDMQDqKbgjNyUGBNUn1rFcbilujrzstNBJHdf2tBSOwcqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4255
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
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Wednesday, February 16, 2022 11:35 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net
> Subject: Re: [PATCH v1 1/7] Documentation: fpga: dfl: add description of =
IOFS
>=20
> > Subject: [PATCH v1 1/7] Documentation: fpga: dfl: add description of
> > IOFS
> >
> > From: Tianfei Zhang <tianfei.zhang@intel.com>
> >
> > This patch adds description about IOFS support for DFL.
> >
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  Documentation/fpga/dfl.rst | 99
> > +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 97 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index ef9eec71f6f3..6f9eae1c1697 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -58,7 +58,10 @@ interface to FPGA, e.g. the FPGA Management Engine
> > (FME) and Port (more
> >  descriptions on FME and Port in later sections).
> >
> >  Accelerated Function Unit (AFU) represents an FPGA programmable
> > region and -always connects to a FIU (e.g. a Port) as its child as illu=
strated
> above.
> > +always connects to a FIU (e.g. a Port) as its child as illustrated
> > +above, but on IOFS design, it introducing Port Gasket which contains
> > +AFUs. For DFL
> > perspective,
> > +the Next_AFU pointer on FIU feature header can point to NULL so the
> > +AFU is
> > not
> > +connects to a FIU(more descriptions on IOFS in later section).
> >
> >  Private Features represent sub features of the FIU and AFU. They
> > could be  various function blocks with different IDs, but all private
> > features which @@ -134,6 +137,9 @@ reconfigurable region containing an
> > AFU. It controls the communication from SW  to the accelerator and
> > exposes features such as reset and debug. Each FPGA  device may have
> > more than one port, but always one AFU per port.
> >
> > +On IOFS, it introducing a new hardware unit, Port Gasket, which
> > +contains all the PR specific modules and regions (more descriptions on=
 IOFS in
> later section).
>=20
> What's the different between the PORT we have now for DFH, and the new on=
e
> in IOFS?

From DFL perspective , the PORT concept is identical between IOFS and old c=
ard like N3000 card.
The major different is that the IOFS introducing a new hardware concept: Po=
rt Gasket, which include the PR slot,=20
Port control, Port user clock control and Port errors.
>=20
> > +
> >
> >  AFU
> >  =3D=3D=3D
> > @@ -143,6 +149,9 @@ used for accelerator-specific control registers.
> >  User-space applications can acquire exclusive access to an AFU
> > attached to a  port by using open() on the port device node and release=
 it using
> close().
> >
> > +On IOFS, the AFU is embedded in a Port Gasket. The AFU resource can
> > +expose
> > via
> > +VFs with SRIOV support (more descriptions on IOFS in later section).
> > +
> >  The following functions are exposed through ioctls:
> >
> >  - Get driver API version (DFL_FPGA_GET_API_VERSION) @@ -284,7 +293,8
> > @@ FME is always accessed through the physical function (PF).
> >
> >  Ports (and related AFUs) are accessed via PF by default, but could be
> > exposed  through virtual function (VF) devices via PCIe SRIOV. Each VF
> > only contains
> > -1 Port and 1 AFU for isolation. Users could assign individual VFs
> > (accelerators)
> > +1 Port (On IOFS design, the VF is designs without Port) and 1 AFU for
> isolation.
> > +Users could assign individual VFs (accelerators)
> >  created via PCIe SRIOV interface, to virtual machines.
> >
> >  The driver organization in virtualization case is illustrated below:
> > @@ -389,6 +399,91 @@ The device nodes used for ioctl() or mmap() can
> > be referenced through::
> >  	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
> >  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
> >
> > +Intel Open FPGA stack
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Intel Open FPGA stack aka IOFS, Intel's version of a common core set
> > +of RTL to allow customers to easily interface to logic and IP on the F=
PGA.
> > +IOFS leverage the DFL for the implementation of the FPGA RTL design.
> > +
> > +IOFS designs allow for the arrangement of software interfaces across
> > +multiple PCIe endpoints. Some of these interfaces may be PFs defined
> > +in the static
> > region
> > +that connect to interfaces in an IP that is loaded via Partial
> > +Reconfiguration
> > (PR).
> > +And some of these interfaces may be VFs defined in the PR region that
> > +can be reconfigured by the end-user. Furthermore, these PFs/VFs may
> > +also be
> > arranged
> > +using a DFL such that features may be discovered and accessed in user
> > +space (with the aid of a generic kernel driver like vfio-pci). The
> > +diagram below depicts an example design with two PFs and two VFs. In
> > +this example, PF1 implements
> > its
> > +MMIO space such that it is compatible with the VirtIO framework. The
> > +other
> > functions,
> > +VF0 and VF1, leverage VFIO to export the MMIO space to an application
> > +or a
> > hypervisor.
>=20
> So PORT will never be exposed to VM in IOFS design, is my understanding
> correct?

On IOFS, there are many methods to access the AFU for virtualization and no=
n-virtualization usage.
1. Legacy Model. This is used for N3000 and N5000 card.
In this model the entire AFU region is a unit of PR, and there is a Port de=
vice connected to this AFU.
In this model, the follow of exposing to VM is the same we have in N3000 an=
d N5000 card.
The major follow is:
* release the port device.
* configure the SRIOV
* assign the VF to VM
* put the port device back to PF after finished access in VM
2. Micro-Personas in AFU.=20
IOFS intruding new model for PR and AFU access.
Micro-Personas allow the RTL developer to designate their own AFU-defined P=
R regions.=20
In this model, each PR slot has a dedicate  Port device, the follow of expo=
sing to VM is the same we have in N3000 and N5000 card.
3. Multiple VFs per PR slot.
In this method, we can instance multiple VFs over SRIOV for one PR slot, an=
d access the AFU resource by different VFs in virtualization usage.
 In this case, the Port device would not connected to AFU/PR slot, so we do=
n't need to release the Port device.
before we assign the VF to VM.

Which model will deploy in IOFS product depends on the RTL developer.

>=20
> > +
> > +     +-----------------+  +--------------+  +-------------+  +--------=
----+
> > +     | FPGA Managerment|  |   VirtIO     |  |  User App   |  | Virtual=
    |
>=20
> s/Managerment/Management/

Thanks, I will fix it on next version.

>=20
> > +     |      App        |  |     App      |  |             |  | Machine=
    |
> > +     +--------+--------+  +------+-------+  +------+------+  +-----+--=
----+
> > +              |                  |                 |               |
> > +              |                  |                 |               |
> > +     +--------+--------+  +------+-------+  +------+------+        |
> > +     |     DFL Driver  |  |VirtIO driver |  |    VFIO     |        |
> > +     +--------+--------+  +------+-------+  +------+------+        |
> > +              |                  |                 |               |
> > +              |                  |                 |               |
> > +     +--------+--------+  +------+-------+  +------+------+   +----+--=
----+
> > +     |     PF0         |  |     PF1      |  |   PF0_VF0   |   |  PF0_V=
F1  |
> > +     +-----------------+  +--------------+  +-------------+   +-------=
----+
> > +
> > +On IOFS, it introducing some enhancements compared with original DFL
> design.
> > +1. It introducing Port Gasket in PF0 which is responsible for FPGA
> > +management, like FME and Port management. The Port Gasket contains
> > +all the PR specific
> > modules
>=20
> So in IOFS, in PF0, we always have FME and PORT DFH, is my understanding
> correct?

Yes.

> Then why we need patch #3?

This is for " Multiple VFs per PR slot" model, in this model, the Port devi=
ce would not connected to AFU (the BarID of Port device should be set to in=
valid),
so we just can access PR slot/AFU resource via VFs.

>=20
> Another question is in IOFS, do we need to support multiple PR regions/Po=
rts?
> If that is the case, how should we know which VFs belongs to PORT1 or POR=
T2?
>=20
> > +and logic, e.g., PR slot reset/freeze control, user clock, remote STP =
etc.
> > +Architecturally, a Port Gasket can have multiple PR slots where user
> > +workload
> > can
> > +be programmed into.
> > +2. To expend the scalable of FPGA, it can support multiple FPs in
> > +static region
>=20
> s/FPs/PFs/

I will fix on next version.

>=20
> > +which contain some static functions like VirtIO, diagnostic test, and
> > +access over VFIO or assigned to VMs easily. Those PFs will not have a
> > +Port Unit which
> > without
> > +PR region (AFU) connected to those PFs, and the end-user cannot
> > +partial
> > reconfigurate
>=20
> s/reconfigurate/reconfigure/

I will fix on next version.

>=20
> > +those PFs.
> > +3. In our previous DFL design, it can only create one VF based in an
> > +AFU. To
> > raise
> > +the efficiency usage of AFU, it can create more than one VFs in an
> > +AFU via PCIe SRIOV, so those VFs share the PR region and resource.
> > +
> > +There is one reference architecture design for IOFS as illustrated bel=
ow:
> > +
> > +                              +----------------------+
> > +                              |   PF/VF mux/demux    |
> > +                              +--+--+-----+------+-+-+
> > +                                 |  |     |      | |
> > +        +------------------------+  |     |      | |
> > +  PF0   |                 +---------+   +-+      | |
> > +    +---+---+             |         +---+----+   | |
> > +    |  DFH  |             |         |   DFH  |   | |
> > +    +-------+       +-----+----+    +--------+   | |
> > +    |  FME  |       |  VirtIO  |    |  Test  |   | |
> > +    +-------+       +----------+    +--------+   | |
> > +    | Port  |            PF1            PF2      | |
> > +    +---+---+                                    | |
> > +        |                             +----------+ |
> > +        |                             |           ++
> > +        |                             |           |
> > +        |                             | PF0_VF0   | PF0_VF1
> > +        |           +-----------------+-----------+------------+
> > +        |           |           +-----+-----------+--------+   |
> > +        |           |           |     |           |        |   |
> > +        |           | +------+  |  +--+ -+     +--+---+    |   |
> > +        |           | | CSR  |  |  | DFH |     |  DFH |    |   |
> > +        +-----------+ +------+  |  +-----+     +------+    |   |
> > +                    |           |  | DEV |     |  DEV |    |   |
> > +                    |           |  +-----+     +------+    |   |
> > +                    |           |            PR Slot       |   |
> > +                    |           +--------------------------+   |
> > +                    | Port Gasket                              |
> > +                    +------------------------------------------+
> > +
> > +Here are the major changes about DFL structures on IOFS
> > +implementation
> > design:
> > +1. The Port Gasket connects to FIU Port in DFL, but the Next_AFU
> > +pointer in FIU feature header can point to NULL so that it is no AFU
> > +connects to a FIU Port.
> > +2. The VF which include in PR region can start with AFU feature
> > +header without a FIU Port feature header.
>=20
> What about PF2 in static region? Which type of DFH will be used?

An IP designer may choose to add more than one PF for interfacing with IP o=
n the FPGA.
If at least one PF implements a DFL with management features such as an FME=
 or PR, then
the device can be managed using the IOFS software stack. For example, a des=
ign may include
FME and PR on PF0 and the actual workload interfaces on PF1. If a workload=
=20
implements virtio-net backend and interface, the IOFS software stack will o=
nly bind to and
communicate with IOFS features/interfaces found in the DFL on PF0. The seco=
nd PF, PF1,=20
will bind with virtio-net driver presenting itself as a network interface t=
o the OS.
So the IOFS providing the diversity for IP designer.

>=20
> Thanks
> Hao
>=20
> >
> >  Performance Counters
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --
> > 2.17.1

