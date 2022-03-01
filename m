Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D9E4C8461
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiCAGvu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCAGvt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:51:49 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123870307;
        Mon, 28 Feb 2022 22:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646117468; x=1677653468;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HcGmZczv/EbewLJFK7rXGGUy2NevUvAjdctaUyyyAf0=;
  b=T9G0DzqvNRWK+I9AP9W+NNr4VYEDRotoi4SKwN7F4p+66rOzhSCfZSoe
   vjS0tYU8q0tuzdzsruNAR5WfcxveHGhpALxNCEUZxQ0Ojo9OINCVj7NQk
   X7HsQXEcb1BHDGBSaBxM2GFSzVVUoy1eT5SV4+qTvb376DXQgtSfYAQZC
   L+DjFmZCuuhntzGop9aZs07DJ/dps1wjchxYErBMOhiuDJIw3SIIfuitZ
   PiXBHIPkSGRgjphRTDEU9Rt7rlri01frMY1MjsO4RJK7ysGpCY+fCYFsc
   zD+rxsNs6Gyq21+iSoBgywxVqmmV1l5+Tk+KikACHQHCseDLkuLxtMWsf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252999172"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="252999172"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:51:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="507700652"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 28 Feb 2022 22:51:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:51:07 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 22:51:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 22:51:06 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 22:51:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzcOWdQVZLW6gVtXMWp0Eoc7IXWRyNdpqctUMDtF0OWe3ZSpk+zY4J4ktVBrvDzQkIce0SyT9upJh/0xrnzu8UppoB+/CNnff0B6hctO60CFyvIM11IxG6WmVzfMzE/SvN52s/Dkdp5/J+mJOHMwesxJfPSTzIpfMuJxw0iKA/ByfZCfcW7uLR7BNomB9ah+jx+PTmHgstmJK2aZItJ5KX87uGDzJGu2lCixEpB7C+LVQvSX5VMNxmDZXfDOgi7jUwkAMtQ2brGN/sQVPJ26HncTV1P/jHNK8MFsukLhdEGHHPJP+xLpbPykZZocZ/c71Qbdb4Xe3TvaTwyaW7zgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt26sdMZ1hm8ZTpVwh5H1nGmlCPGzeuK6OktjAoy4lQ=;
 b=e+mTPrOr8LmSLJ1oLliXFjjXzgCFEdS3nNWna8HGJQiNt4CZvIsiu+zxQVhjN9ETJblefjlXdWDkHefsE3ViGkblTl+6fa83uK03tIY0bftpnWf0UPVI4e8g5UvJ2ddHt3LkSJCh9zPJUWvCwwpV0BV0p0WwFC17jdTUoBiPeucKYjYwHu0pplVy3ZnTZfFKMnYaZIQlbLO9KylboQuiTEx+gnurinTtjmzBYKaMUQ1DJdaS99EyaGS4dNY9RvhSQeYbKRAQg1TqQSp4+6c39nZCsX3eu2cd79BkBYCdzo7fQBnhhqcQAW1cOM3A2vlRSySiEyPg0r60x9GfSPwphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by BYAPR11MB2712.namprd11.prod.outlook.com (2603:10b6:a02:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 06:50:57 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 06:50:57 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar
 space.
Thread-Topic: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar
 space.
Thread-Index: AQHYLTUOF158WnYz+UaY3Q2B5xB+uqyqFSkAgAAATFA=
Date:   Tue, 1 Mar 2022 06:50:57 +0000
Message-ID: <BN9PR11MB54831F16EA63B2A9E8BEAE00E3029@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
 <20220301062123.818687-2-tianfei.zhang@intel.com>
 <DM6PR11MB38191CD30FC5F6A2AD8F837485029@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38191CD30FC5F6A2AD8F837485029@DM6PR11MB3819.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 21461157-389e-47d0-1231-08d9fb4fd6a6
x-ms-traffictypediagnostic: BYAPR11MB2712:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB271239B108C9B60AB06B2369E3029@BYAPR11MB2712.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5o1sQO5SZQiVYHk/N5ThHppMnukhrQ/c//5lk1uMeSNuNQnjaUgEkJNRlNu1EbiXQaO6xr2tVeB+wv/FdBp3iy2qiAIVIFV6tFw9iAOFpm/vhM/4T8nKSer2tPFmwmfVmK3OJEzuKd337pEV0xUCpMHxStBwZN0jf+ouDToiOTWF1Nob/BetJHvWg0IiYF6O4kPWwGsMu1Dyj5pyIdtSMLimTu2AmVpm1drTVw77HUtO3Ufg31glhNfJVT8mgxHMjS8uJUMkxczfIsEkVh/4Jja3yyLORorndRGmM7I/y0vb0QpIg/YanVrShFo2DFksjPBEH5nFfh3AZWeelJs76cgiVfXhqzQUuLqLObcQIvNYlBxHR+8TrHpwRCuc+ORVXRn4bGSiBAKQCKDq3UL/ZnB1MsYFD4Q2lqYfTJjfEbQzq94QESx0Hjj8+bkU9YCi/upR3h7ERSLvmQR2ouhtgKbvsxLtaYbrpVyWvr9nErwspxgOhI/OB/5QeU/fNJFe1/sMAeX3kjUVok0kP/Y05juoeUGb59GaLKhh5TXQ1m8Buw/U+WRZfTMAMoHFVj9lASIXps8+6GyFSHweqTCSDin8KNZePE9Gfi3kDKfF/LjogYYnWHvEbiLYrE4Y5l6EGtsnG6A8BOEnOTJAMfAZOjyrR74o/96KAZJVEpDyWPYv4Fyfg94fN9b3ygoQ9Xf20YbQNNR8SQEKNlZrsqstcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(38100700002)(54906003)(76116006)(66446008)(66556008)(64756008)(83380400001)(66946007)(66476007)(55016003)(122000001)(508600001)(26005)(4326008)(52536014)(8936002)(86362001)(8676002)(316002)(9686003)(71200400001)(5660300002)(33656002)(82960400001)(2906002)(7696005)(6506007)(38070700005)(53546011)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oinwOpeFS9HskaSxyHN5VE7zokM8nrrRplrhNtzkmF9N+iyyAdb49+KWso7x?=
 =?us-ascii?Q?92H+XQRI2dm45MtZ1ck5LdQwxUUgKR4CgYJgBtwq6VlnlWODyhtCoIwHnwBS?=
 =?us-ascii?Q?bdOe8kwR3vaS/tfY7v5jIjgOEy7pJvCJTX1UWMAlNcT2s/UmJSP4oUJUDgKu?=
 =?us-ascii?Q?9dF0f0FCRDHNo4SeBfFCk5mYUQWzNQUyM1tBP+Gzbt1hTuqG/YFgyDcOEY5A?=
 =?us-ascii?Q?Jthel73nAIoS0tJGvlAQm/kZIA/6A2S/E5jXh3PkUD2mIpC/s5lw+y1f/PIw?=
 =?us-ascii?Q?diMX9Q11bbWZMP3LhAvZLq7zOfkgRhLPN19IBL/nYg3susdUvNDcWrNApY/r?=
 =?us-ascii?Q?wSkiWJ9bC5IRH6VmXn5c6ofx40GC6R7MGcdZhkldChol+oWNL30DCmie2+YI?=
 =?us-ascii?Q?Gu5k119kYJqqdHiDDmgWyXPSfXYhiiCVgwRe2evol7q/26ZoB7IfH9vTYzep?=
 =?us-ascii?Q?n6sz2D0Xbg6dLiSKf1X7VHyfhSkfq/19iujfreu+ZuIexU80XXPWFgzqoLA2?=
 =?us-ascii?Q?ZtU7i3ED4gIk5f6l7j8UW7Zk2Oe89K1PyCuiOCrGMwG+5q/xIHqXjhFFxpnB?=
 =?us-ascii?Q?F4Kvu6Kf5V6S7dprOQNDG3phGkxNt/awgQIlbmuPawJP63xg+reOU9bAfUUf?=
 =?us-ascii?Q?Yz5WWUpoaFIFTwXKQwrbCXVDVfoKWDwoyCblBYThmm7j05d99w+B3bf3JmzV?=
 =?us-ascii?Q?f+/AU8rYcNGgoR/oUaLGTJlu3T3uk8emOA9GOzUCnLrfwDD94AD+ijYmYIPE?=
 =?us-ascii?Q?ewn5bwWsEei45KP2Q/4QHNQoJvD9GCfiQPgK1dUm+t08jzrSkj6sfdJ4E5ZC?=
 =?us-ascii?Q?0aBygK+k5hY55NwhOfD+j8/nCLpwcnBnYwU+04N+R3Ebo6EwL+nGr/vbupwj?=
 =?us-ascii?Q?qozuDpAfe5m2lpjydpQCA0V/fqTzl6D3R2otkUBeHDGXvBKeoJfkFmXIkbDV?=
 =?us-ascii?Q?XuPLy2rxwbE+TD1PXPzHCKGhimnItwy3NPL5oH1GJgBCEcf0+/1FgUpavIrV?=
 =?us-ascii?Q?Nu5uf81P9qpfT0zaj1UPEhJvoGC874dXbzzeLsY21/E/tOuHhCpAB/65Ps35?=
 =?us-ascii?Q?YTe4LxaqaAhf0Qlz61Dc4HgzWBuBlw7Exo+4w/0NpIDw4zjwRWOgLPMkuYWu?=
 =?us-ascii?Q?qr0lEOdUxVU7KZxll0iWbZx13wQI2pVmKaUXCa47XwmydFLbB7kpNN0yBbEW?=
 =?us-ascii?Q?R7W8X4yi7a3BC8555N0uIhvPyvtUdaMqt4d3dwxQJod0tn5TG5LbTCnonDlu?=
 =?us-ascii?Q?QYns3sC/iM/1VCo18i3sBntqVzyhx6JvPSDuoM2oOd5r4K6CzyDtmhNdCMmf?=
 =?us-ascii?Q?YQDfW1l+FYPxDnEBUnSxqUXbSlIJj3S7U7NUW9cXtiS/PoIVHyyJ+Ar9qKdJ?=
 =?us-ascii?Q?RuZKYz1p4SIAKVvK4gbJKHaaVMGyqFD3HnCezzeZrWaP/gUIKAAKFWOUksdg?=
 =?us-ascii?Q?ZHN7ZrbkYmFQ8xrd8jGcMhADlkDfLdu9lPsCsXKEtEvvuJnrQKdA86vpGBHW?=
 =?us-ascii?Q?8xYl+jxposoV2Un7z1PkCU11ZhWUyeEzyYs+Gtb/OkrRk5BQLep6fxLT0jxo?=
 =?us-ascii?Q?uh1Hd/+pudgglxt6kIg2Qi92ruoY1yRavB6Q4tID03kVnIBa+Kp1aH8y0ETN?=
 =?us-ascii?Q?hg49uB5ChrMrtEvEP7LCaK4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21461157-389e-47d0-1231-08d9fb4fd6a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 06:50:57.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJVeOjje183e9bZmH4u6ump8uwquatP6/Q6FaKoRNBXJyIuX70Ez2Iha+rMIL+EhmmhUtgUfsDUEjfMgwNTWIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Sent: Tuesday, March 1, 2022 2:44 PM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>
> Subject: RE: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific b=
ar space.
>=20
> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Tuesday, March 1, 2022 2:21 PM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > linux-doc@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
> > <tianfei.zhang@intel.com>
> > Subject: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar=
 space.
> >
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > In OFS, there is a Port device for each PR slot, like Port control,
> > Port user clock control and Port errors, those feature devices are
> > linked with DFL. The DFL of Port device was located in PCIe Bar 0 MMIO
> > space by default, but it also can put into any
>=20
> There is not default BAR for Port. In OFS implementation it could be 0, b=
ut not
> default value for other implementation.
>=20
> > PCIe Bar space. If the BarID (3bits field) in PORTn_OFFSET register
> > set to invalid means that DFL of Port device is located in the Bar 0
> > by default, in this case, it don't need add the Bar 0 into dfl list
> > twice.
>=20
> So why not just use existing method (e.g. BAR0 + offset) to locate DFL of=
 port?

For N6000 card, this BarID in PORTn_OFFSET register was set to 0b111 in RTL=
, which is larger than the maximum PCI BAR numbe PCI_STD_NUM_BARS,
So for software perspective, this means there is no additional the BAR spac=
e of this port device, but the DFH of this port device
still located in BAR0.

>=20
> The title is confusing too, PORTs still have its BAR location/space.
>=20
> Hao
>=20
> >
> > ---
> > v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 6 ++++++
> >  drivers/fpga/dfl.h     | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > 4d68719e608f..33545c999c06 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -258,6 +258,12 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar >=3D FME_HDR_NO_PORT_BAR) {
> > +				dev_dbg(&pcidev->dev, "skipping port without
> > specific BAR space %d\n",
> > +					bar);
> > +				continue;
> > +			}
> > +
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h index
> > 53572c7aced0..1fd493e82dd8 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -91,6 +91,7 @@
> >  #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
> >  #define FME_HDR_BITSTREAM_ID	0x60
> >  #define FME_HDR_BITSTREAM_MD	0x68
> > +#define FME_HDR_NO_PORT_BAR	7
> >
> >  /* FME Fab Capability Register Bitfield */
> >  #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric
> > version ID */
> > --
> > 2.26.2

