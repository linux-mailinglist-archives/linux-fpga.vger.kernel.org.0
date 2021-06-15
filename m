Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE5A3A78C9
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFOIKw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 04:10:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:64087 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhFOIKv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 04:10:51 -0400
IronPort-SDR: mEXhtBDZD5dkr23h9oJCyrkrliTUVNElRoraU6pYkRq8dZCYkshXtDex7zfG6LFrZETvtf2V/g
 93K6wBKaasLA==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="186319086"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="186319086"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 01:08:42 -0700
IronPort-SDR: 73+l2LyBXMTIAmKrYbf2LFrJoBS2TGQtKjN0qpPygzYX9xD4ZZlFmKPA2qpChgcNZtv0BeltKy
 q/OzUJUNJEow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="442480661"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2021 01:08:41 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 01:08:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 01:08:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 01:08:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 01:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZVCDQk6lIjM+3kyH05CPYG/RFhrCQjdIf3XbOX5AoZBr3dPQ5EAIovT7zgIeudr3QriwBbbMOZY7+/ejlfWOC+6ZlziV+46XCTbuDFB5PS5DAKpX9IWKwE7PVkr1HBklTmzkagC8jxanEfr0WPPIDcUDcd8p5J+NVRza8oDwLjAWPPXiXdu/Vlk7fdAp9DUAdPNtnfptcRp4yr9q9EmtCoYxAqbk7npCAgYVT2Mg9+9EGkZezoUZJVaOFT6XWQSWqm6fNnyMXOsKmnJU2hYESvLWsKGOtfoUSXwCKTihVx5aXPKkJIwQa2NHEBoW+NZVmw+vRBiSywLkVfdAEJweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al/b/OCWWGwHTJVxKmpRZp0zqKpHW2fLuFpDBn0XRog=;
 b=ZAVBPJ9eRf+fH0Vs87CcNBEeJ0/DADfuJkZ+ztmLWxozZy9EePwLJXPCOFzD9t5YMKFRYijT35B+bkNm8j4b4KbqGR/CHAgTOycBV3vgEEMOTKoO6GsUIQZcvdQ9/dwOPZqpV2mFF0zoc+CnCR5yAYZpK+v7N++m9Nyuv3LDgULK475qp6GyZw4EUKWgoNmTr00OTKUgo70UwP1SJAXpvuPyFNtM29miGtGlPxGsqxqoZC9pjExZ8mFbDa9MWzJvrRJPpOSWN0fJ1OvuWC7/vFmjgLe4ckULr8DY0V0Gq9lvHGCYP91P6ubroLb9ycDDSmzEf6UtPk+Ku1AY8gTq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al/b/OCWWGwHTJVxKmpRZp0zqKpHW2fLuFpDBn0XRog=;
 b=joj6yLULAOKjIbACnO6bgl2mhYX2HflVQu1/B26zejOZHOlB5c0UtPgd9MYlc3JBHhwq7VE/4qLcCbmeebYEG7DQiY5KecamdDZHEQUL2wepBi2mcOTAuKJ8sIqZ3YViQQVkvBvxeSrKnoS77nthSNteob4FUuePS0uLedN5Lys=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB0074.namprd11.prod.outlook.com (2603:10b6:4:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 08:08:38 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 08:08:38 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Thread-Topic: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Thread-Index: AQHXYVpMuuq4CCKpI0OAe3HAOe9lxqsUps2g
Date:   Tue, 15 Jun 2021 08:08:38 +0000
Message-ID: <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
In-Reply-To: <20210614201648.3358206-3-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e58d4b1-defe-4788-a1cd-08d92fd4c7e8
x-ms-traffictypediagnostic: DM5PR11MB0074:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0074EB5145EA404E4670337E85309@DM5PR11MB0074.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udYlhp7C6VZK9rSC8Ra2U+qIegk3OK7dQU4Sxs4RiRYG/W0eMFFSXXprAskAY0H1hKymJo8NNZA19zR3NA/3Lm/T1mpIsdO1YWcQ5aDTC+Y/7yAFqvotc2wOhyX7J70nzaxfoyti6Wy4oETizI/d6GdV7F9i87WLZWtLSL8S9qItQwUzxf0yATQAquP98jrt+2gznTq5NWrvaKGit8OCsTBH2rdvK7bHHgWgac+GLN/NkTb0cnekN0G3w/ECZN8eWZMW03SdQACEvd4G5MAI0zABfoDwhlpiEm1FKHmfSDLNKb/8gcDUuBJ8/5UrmrrZqqMJG2A4icRT6c4I5Gbw9y26iW01qmbI2+jRNFBZETTGg95MbyS0Ja5g9R9zjbeHqJBA8car8DPXwmN68zgEKB1YxpdQ7kS3dzEKTELIyEtbQfSJUY7bka5uMPb2amEaVVy3jDQQu2Wz+U0wTa9aeu3vhScBPOHsDZn/sTHYkpIcdy36YbbeVmAA1pdKbTFotAUk1Xh1XHxOF3Pzx70yQUSDoKOxzsySu5IPOIbofuTjKJQ2qQl/ojbW6j7/h6RaItQhJB0+kJiph+ALlTJwjIOlTRnw9BUQXhM0RafZ4iWLsU/tef3Ra5aUefSSG0kQiilSM7PycrguvqTcOngTaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39860400002)(122000001)(110136005)(2906002)(38100700002)(316002)(478600001)(7416002)(4326008)(55016002)(6506007)(7696005)(54906003)(66476007)(83380400001)(52536014)(86362001)(66446008)(66946007)(64756008)(76116006)(186003)(8676002)(66556008)(8936002)(921005)(26005)(33656002)(5660300002)(71200400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TIkVgoeBd9XTPb4D+jaORcf51mhNWq5Wu7r4VVUSRnOL6FHjc0kqkb2IodAo?=
 =?us-ascii?Q?8whL136bRsTI9AeLeeeYsX7ilkfwu0kpajeH2olE6K2ox0autSHVoKWT4ANF?=
 =?us-ascii?Q?/PnnQ2tK3QKytjsrQcH2AV4K1srM1LijYV0Oefh33kEN17a/3VHIMwGevbJt?=
 =?us-ascii?Q?mFE6ieYBXQmNH3EAcTQIKB3rHncneQfnKHg8bddEB2MXun5LhxurLb13qiVz?=
 =?us-ascii?Q?nwxmNXCYtlmh9KSAVjePAMIO8hzjuAmmpZ/5w5Hx8lCxjGnO4OeVLpBLeTcI?=
 =?us-ascii?Q?iS/K6y+3OUYQ6peBmDs/letJxmXPbFDJDtl82zZnVb0gkrqcKsKazpmnI7Fh?=
 =?us-ascii?Q?WLn9RjEIMXWRKlnBX7rlxk5WtKOc5IeHh7Hx1aq2DIGE0luEI3XhG/XiC8wq?=
 =?us-ascii?Q?XvflEtudP6IL6uUC2CSeCyqRZhm/EonT5dg/vnY+zp14zW67YI75NfDlov9a?=
 =?us-ascii?Q?fEjrj4UNoklI10d/xMsznnyWVwn3Dyv3NGtTgxgVCoHqAAtEPhAY1HoaWl3H?=
 =?us-ascii?Q?J/l/21WfBNYEtYunxpmHRDnLyVyfcixW2Hn2Un8jCrirnFBJkT/YrFk9IZhz?=
 =?us-ascii?Q?+L2ucrAH6oefQECcT6znut+cACZVe5zjER3tPZA7toB2p/PsxC0isHkWhUGK?=
 =?us-ascii?Q?DhqfKCjlC+9KmFokg5UznN6LvYjSiLxJcbMY3dmeUhmKH06g965bY90XS6uD?=
 =?us-ascii?Q?SaPWByixoh2aixuTtPS3szPOZjm1CXEVUGRBRp2qOxUp+MtZpKXc+rTnofzC?=
 =?us-ascii?Q?vwIv2y0afodK2BcuB1hbnjaeUg9BGSwT9TEkgrkxgq0BCr5KD7B1NyS7Oqlz?=
 =?us-ascii?Q?QE5Cv2HdVJXYlnauBWwdQoBynPcCU8N7ROTwS863tW6OXrvLLucNZguevpl0?=
 =?us-ascii?Q?FtVnmngcJIXZHakHU9zKx1U6JNBzW5ag4O+tX437MNlE33r70/iaG+vXKfhx?=
 =?us-ascii?Q?6I0/aWVjt9rbxVlZvFGf9vkGUO4kOJHxJEejhzEDgw/C4ytluk/X6PawV89i?=
 =?us-ascii?Q?2mnLNMPnfaeWMVwWJr6PgS8z8ZhR6JaSOi3sy5NO53fswKCNi8hpTJXbk+NK?=
 =?us-ascii?Q?fgHHnCZXPjJIVAOouRV935+V/Pdm4474zMv6HXvlyMrwzQD16zLfD13QZUa3?=
 =?us-ascii?Q?snWRgZh9iUubOVQeFzcrVWlbWn6ooT5Hot910puFN5nhyRFPRFqNkSS7x495?=
 =?us-ascii?Q?gQRaC2UZmWty8DCoKiVdtkPBWfb0Uf77wujZyffOP6wS0IqNokV4M3Lu/TCU?=
 =?us-ascii?Q?2y1vJvxs3uGfj8jsb83/SO1buJBeg+N5UZ9lzIExKmTBBDGi0vV1tijtHtXy?=
 =?us-ascii?Q?clheXSJK/S57b1fAaGqkq93t?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e58d4b1-defe-4788-a1cd-08d92fd4c7e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2021 08:08:38.1710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXopitGeZusr6TC21mJvvEDoy5g0MSmmF1ErJeINfDkduH/TLTbkd+37pK2mrMA5fzCpM7lis3zI1SmEc1wOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0074
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
>=20
> From: Tom Rix <trix@redhat.com>
>=20
> Follow drivers/net/ethernet/ which has control configs
> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> Since fpgas do not have many vendors, drop the 'VENDOR' and use
> FPGA_BLA.

Hi Tom,

Thanks for this patch. : )

DFL is not a vendor, but something can be shared/reused. It's possible that
other vendors reuse the same concepts and the drivers of DFL. If vendor
drivers need to be moved inside sub folders, then maybe it's better to
leave DFL in the parent folder?

>=20
> There are several new subdirs
> altera/
> dfl/
> lattice/
> xilinx/
>=20
> Each subdir has a Kconfig that has a new/reused
>=20
> if FPGA_BLA
>   ... existing configs ...
> endif FPGA_BLA
>=20
> Which is sourced into the main fpga/Kconfig
>=20
> Each subdir has a Makefile whose transversal is controlled in the
> fpga/Makefile by
>=20
> obj-$(CONFIG_FPGA_BLA) +=3D bla/
>=20
> This is the dfl/ subdir part.
>=20
> Create a dfl/ subdir
> Move dfl-* files to it.
> Add a Kconfig and Makefile
>=20
> Because FPGA_DFL is now used in dfl/Kconfig in a if/endif
> block, all the other configs in dfl/Kconfig implicitly depend
> on FPGA_DFL.  So the explicit dependence can be removed.  Also
> since FPGA_DFL depends on HAS_IOMEM, it can be removed from the
> other configs.

Hm.. sounds like this change (remove HAS_IOMEM) is better to be split
into another patch. How do you think?

Thanks
Hao
