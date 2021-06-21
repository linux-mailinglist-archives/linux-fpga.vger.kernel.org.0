Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE03AE678
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFUJvL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 05:51:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:38084 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUJvK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 05:51:10 -0400
IronPort-SDR: KXw3EESNGxYi1j7Fe0SSSyWkzLztIKCrprso7wAPVFaUHSJCRX5Yqmrep3jgTy6791glIv3yeJ
 kWH2iHtaYAUg==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="228355385"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="228355385"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 02:48:54 -0700
IronPort-SDR: OFxe2TCgKFCDHGdRklmYGy42wr3UjsmDP+EdH7Jxo7d5+U4zQ9R884ePOUiZ+HgsZUuQw1rpi4
 PULYXVYIXDAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="422885244"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2021 02:48:53 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 02:48:53 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 02:48:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 21 Jun 2021 02:48:52 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 21 Jun 2021 02:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kte1rpj7Qm8D1hzLfTQfgu6HNTq9kibdUvypgwv1t5gyaIi2DkCZNEH8VFNouJvTiDV55fDloMEXCjmBtVQjD2YgLg2XMQJpXFmJ0+TQP7UiS6wHsiTsnz1oVLxfWrC7JySWsGYlXYuimKbLcWZBfWkpdRMAtzWEf6p0QZRJ1D2IStdFscHTES1w7AulxLiy+p7nTmTxn6iA1eleLXDVQjO1hEJlwU4QVfZNOKimT/K0pT/pY+naMU4RcxaCY15rZ0WIO0UVB00F4hdNL+pYIrv/BCr2S95o5nX/wzEJGCq1e5ZLFQdyz5TmTB7HfzpsfO1XQwdVRQv7etsqq7UBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kK73C7LKtOYPaubYB02I8+Qfv8NHXecdNDQh852m88=;
 b=gbvZ+kZVQLIoGvu6k+BtwA9Xo3xrLCq0lb8cmh6dDcm807ywlSurGffmE2SfGAHQHAS+T8DqXmISIX9uTfc8rFWkZhaiyT51pV8UuCX+99bAPPZf/9osxQcHyUQW/cz/N/vDYb8tNLYYJAwCES/KVfj6wrQFRynMpBgFoP77L1tnPyqVKMV6OJMfR9bcQaQFP+rNc9eEvxR1DIP+tRBYwkX2wPQixkmgi07+HUlDN7JqSRmM1hkjqSS7gIqOcM1sGmLoIOgN8AwlfuSz0tHcL5gQQgoRm+Che03c1Tmi6qwdmMEBAnAoYvEneianEFClUTHw3anPSQxwuaGsUgvrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kK73C7LKtOYPaubYB02I8+Qfv8NHXecdNDQh852m88=;
 b=Dx/5AfdbWJcSWcGXn6ATexMAK+UKgT1rc9IrVUopmiYdqR+VldE4+1AtxRTQbVVOmKa4DRR9w86qga6mllBegsW60nXdloP8GLSNlBybEb1kBMDkU4/2SO2L2Uy1foWceh0AS/tLlQFHpZJ24kxdWjIQ6OZn5SzywMcQnxA9EtI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2571.namprd11.prod.outlook.com (2603:10b6:5:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 09:48:50 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 09:48:50 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
CC:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        "Gong, Richard" <richard.gong@intel.com>
Subject: RE: [PATCH v5 1/3] fpga: mgr: Use standard dev_release for class
 driver
Thread-Topic: [PATCH v5 1/3] fpga: mgr: Use standard dev_release for class
 driver
Thread-Index: AQHXYwMPs4aRDCQatEGStgPCWyw0TKsZ7AUAgAAE9YCAACAeAIAALQMAgAAW7YCAA+WEUA==
Date:   Mon, 21 Jun 2021 09:48:50 +0000
Message-ID: <DM6PR11MB381991DCF48578CDB55FBF78850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210616225740.399486-1-russell.h.weight@intel.com>
 <20210616225740.399486-2-russell.h.weight@intel.com>
 <20210618154554.GA5626@yilunxu-OptiPlex-7050>
 <beca500b-a66c-d6fa-1452-3e7513394d0e@intel.com>
 <69a0135d-ad0b-49ea-f741-54c982a0e5f3@intel.com>
 <2253ceae-8c9b-9176-4ec2-88e84c2b627a@redhat.com>
 <YM0XyY9d+13GQyCS@epycbox.lan>
In-Reply-To: <YM0XyY9d+13GQyCS@epycbox.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb0d17c6-58d7-4e5a-f879-08d93499c61f
x-ms-traffictypediagnostic: DM6PR11MB2571:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB257101FF53D0E625E99F471A850A9@DM6PR11MB2571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ntD+4bXtzBcsTNc4eA5/iBwRlaJ/C+tPCQ51SRD+mDKaUGckQ5hC5VybB4IpHO8azqK+vmYqF5P/0DO5DhKhe2XPuF3kFHXBryma4hjzFeq9eldSxNQAa9DyvagZi0p8ZUgWeQkosid7a+r8WIon5eMBGNh4nzbLyXhsJYN0hW7JRuuDyzkRES5G80VV1RFxpqFvVaXZhAMAPR562qY6i+UePc5h3hgZMpvtlL2nPBe0/fdXPgN6isMSAlBw62hoZmHscMWqkWjWlVXYDxdqU81gDMxJXSg1ZG0pN+9NkY5OvRYnlQnd1vIG9DQAXai2fgvCK7I+ixTt4wWRfIgJGJTJf/ZWmmw9C/5b/rNqurbTx+pvM1CLmJkk3n2prlOh73FyJswGPMrKZ1Ms3FknVYTiWjiTisWshJrHmH8W0P4zYjaacJeqQfmVglX9Bi0Xipthf2vlmqbCehyxvlE9V+zS8BwmZQqVkiXFIgcz5ktnf7GuU5/yPS0H4EwIKa9p12Zzm27SsbVX+eEZQOyGQASkM7h25uG/4faroIrox/jDbO6zb3TXnpHxmvp40i/PLtTo1uGtI3VBkCQb9MX6l0Jn7Cv60igGObBRgBOt/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(136003)(396003)(38100700002)(122000001)(55016002)(9686003)(5660300002)(83380400001)(71200400001)(30864003)(186003)(86362001)(66476007)(4326008)(316002)(8936002)(8676002)(478600001)(76116006)(66946007)(2906002)(64756008)(66446008)(107886003)(66556008)(54906003)(33656002)(26005)(6506007)(53546011)(52536014)(7696005)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ycE89ye1oboCbU+11e8BF4AzttSZXsphEoyEOAiX2eXuZQ1j985yR3Xbf/yv?=
 =?us-ascii?Q?ec0iRGNcB15yrF03B/A3Oqd2xpwOhRMfy/mkP3/OGoPTQ4ACw+bdS+QkQRkA?=
 =?us-ascii?Q?Taq+j7QnvP+XUaK4oVjmwTL7Lt2Io0qeSKx4li6wfFKjA1d4P6LJCDGa510k?=
 =?us-ascii?Q?gUMa019wqfDLq2+d4RU0hyTy2+iIPwHAky9O70yqqM3iMb8c1kyxaz7PLg+l?=
 =?us-ascii?Q?lOyGShgM8K3UVg1OGabZTeQItkGhD7h0djJmo6wWOXdTzRIeImSYqukcANup?=
 =?us-ascii?Q?5/Jh8oEMr1OypptEGhiS7iTUYV4jTqNSE3SlfVJETvsWOOwEj9AH0oYnFXvz?=
 =?us-ascii?Q?LsLOlzSMTSpqhFjbpIFBgiRkSX75smIr22mcr/64DwCL/GNRKcEq3cyETXNM?=
 =?us-ascii?Q?0dlzx3K/lMgwgH6iBtDa2s7yKfOjiEg1dpr4EkGoX33yXZ7FvZtQUNbwG4OL?=
 =?us-ascii?Q?kr/aD+4lIetzQUVouKdr9vecY3fmk6Xsku/DgVxOUlPh+Es/T5nL11cdjwX0?=
 =?us-ascii?Q?5e3Xwj7LR9d1OT66S9T0lanfe+Fa9JH0v346cGHMIIhZII/RdXImyVnmeqSe?=
 =?us-ascii?Q?qlw9gA17IbfP1mb7i0RkVTnjh4X/qnmIPD9sHc9TmynDzy4Oimf+Qp4aI6yt?=
 =?us-ascii?Q?Gn24OgtIfAeox3JhpiFwobN0hvHHoLQZI9SgmhwJmzviUYzuGhSYA8KcSqnX?=
 =?us-ascii?Q?uKv1VIcCCT2a1VgnPE/3kg8ix/TPo/NZ2axbCBrAuDxWWUQBW5z4cJUWqMG9?=
 =?us-ascii?Q?T6DltOXtxN+KJgrftV/C7xvl8O5jJ/3PFyaTq1q6jT0NR88IYjK2UOss7K+L?=
 =?us-ascii?Q?x60Asxjf8mgZwfR7FzM+pXQLDvvevViiN43UoLO6WGG4Dg2DVbSK8BKjik6U?=
 =?us-ascii?Q?cDBykrvpAvIQuDfC2Wl62XVNElRftErnAHnGxH1ymNQ/8HFPCg+K81OCr7PX?=
 =?us-ascii?Q?JFxhwh+hSNIajpOFdMI+G3J/CmteAS9ip7goc9f18xUVIS9gY+pWz5+Pod1s?=
 =?us-ascii?Q?PjnYmH9g4a12QWpehYx9gB65RrF3LiurJ/bn11WB/B8KXhnk17hCxC5gh7UL?=
 =?us-ascii?Q?33EgOsneOFOKmbXETWVKdWTxljzSTEuyDJAx/41tE//xAp8UzdtAJYNfp9UX?=
 =?us-ascii?Q?5LPYMBalWwT0osSBtTRJCm31EB1Z9IG+2KJS3YogPDSwnr1JzivqKcekDqer?=
 =?us-ascii?Q?wY8bweW5tZYu3eMK2evuRXex60n4F+oHDqL0qmyWklAc/bKak2gPivmgHSuI?=
 =?us-ascii?Q?65IF8ZbJYlYzDhTxhjbT08yabqAN9LewtkerjXx2zT+PL3k09yzWqHXN0keS?=
 =?us-ascii?Q?CUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0d17c6-58d7-4e5a-f879-08d93499c61f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 09:48:50.6891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNFszAt+Ob0a5zTsD0vPQKVvhenOQXEdIUKpzps3ZVwEJTqMx+gIDf+uBHZ8GsDjq9dKn4H9JJW5nOs8XQFOBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2571
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Fri, Jun 18, 2021 at 01:39:42PM -0700, Tom Rix wrote:
> >
> > On 6/18/21 10:58 AM, Russ Weight wrote:
> > >
> > > On 6/18/21 9:03 AM, Russ Weight wrote:
> > > > On 6/18/21 8:45 AM, Xu Yilun wrote:
> > > > > On Wed, Jun 16, 2021 at 03:57:38PM -0700, Russ Weight wrote:
> > > > > > The FPGA manager class driver data structure is being treated a=
s a
> > > > > > managed resource instead of using standard dev_release call-bac=
k
> > > > > > to release the class data structure. This change removes the
> > > > > > managed resource code for the freeing of the class data structu=
re
> > > > > > and combines the create() and register() functions into a singl=
e
> > > > > > register() function.
> > > > > >
> > > > > > The devm_fpga_mgr_register() function is retained.
> > > > > >
> > > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > > ---
> > > > > > v5:
> > > > > >    - Rebased on top of recently accepted patches.
> > > > > >    - Removed compat_id from the fpga_mgr_register() parameter l=
ist
> > > > > >      and added it to the fpga_manager_ops structure. This also =
required
> > > > > My reason for this change is, we could avoid further change of th=
e
> > > > > fpga_mgr_register() API if we add new input parameters later on.
> > > > With this patchset, changes are only required for the callers
> > > > that use the new parameters.
> > > >
> > > > > >      dynamically allocating the dfl-fme-ops structure in order =
to add
> > > > > >      the appropriate compat_id.
> > > > > But enforcing the dynamical allocation of the parameters is not p=
refered
> > > > > to me. How about a dedicated structure that wraps all the needed
> > > > > parameters:
> > > > >
> > > > > struct fpga_mgr_info {
> > > > > 	const char *name;
> > > > > 	const struct fpga_manager_ops *mops;
> > > > > 	const struct fpga_compat_id *compat_id;
> > > > > 	const void *priv;
> > > > > };
> > > > >
> > > > > Then We can simply define a local variable of this struct for
> > > > > fpga_mgr_register().
> > > > >
> > > > > more details inline.
> > > > I agree the at the dynamic allocation is not preferred, but it is o=
nly
> > > > required if compat_id is used. In all other cases, the static struc=
ture
> > > > can continue to be used. In otherwords, only one caller is affected=
.
> > > > > > v4:
> > > > > >    - Added the compat_id parameter to fpga_mgr_register() and
> > > > > >      devm_fpga_mgr_register() to ensure that the compat_id is s=
et
> before
> > > > > >      the device_register() call.
> > > > > > v3:
> > > > > >    - Cleaned up comment header for fpga_mgr_register()
> > > > > >    - Fix error return on ida_simple_get() failure
> > > > > > v2:
> > > > > >    - Restored devm_fpga_mgr_register() functionality, adapted f=
or the
> combined
> > > > > >      create/register functionality.
> > > > > >    - All previous callers of devm_fpga_mgr_register() will cont=
inue to call
> > > > > >      devm_fpga_mgr_register().
> > > > > >    - replaced unnecessary ternary operators in return statement=
s with
> standard
> > > > > >      if conditions.
> > > > > > ---
> > > > > >   drivers/fpga/altera-cvp.c        |  12 +--
> > > > > >   drivers/fpga/altera-pr-ip-core.c |   8 +-
> > > > > >   drivers/fpga/altera-ps-spi.c     |  10 +-
> > > > > >   drivers/fpga/dfl-fme-mgr.c       |  52 ++++++----
> > > > > >   drivers/fpga/dfl-fme-region.c    |   2 +-
> > > > > >   drivers/fpga/fpga-mgr.c          | 163 ++++++++--------------=
---------
> > > > > >   drivers/fpga/ice40-spi.c         |  10 +-
> > > > > >   drivers/fpga/machxo2-spi.c       |  10 +-
> > > > > >   drivers/fpga/socfpga-a10.c       |  16 ++-
> > > > > >   drivers/fpga/socfpga.c           |  10 +-
> > > > > >   drivers/fpga/stratix10-soc.c     |  16 +--
> > > > > >   drivers/fpga/ts73xx-fpga.c       |  10 +-
> > > > > >   drivers/fpga/xilinx-spi.c        |  12 +--
> > > > > >   drivers/fpga/zynq-fpga.c         |  16 ++-
> > > > > >   drivers/fpga/zynqmp-fpga.c       |  10 +-
> > > > > >   include/linux/fpga/fpga-mgr.h    |  43 ++++----
> > > > > >   16 files changed, 153 insertions(+), 247 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cv=
p.c
> > > > > > index ccf4546eff29..4ffb9da537d8 100644
> > > > > > --- a/drivers/fpga/altera-cvp.c
> > > > > > +++ b/drivers/fpga/altera-cvp.c
> > > > > > @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_de=
v
> *pdev,
> > > > > >   	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
> > > > > >   		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
> > > > > > -	mgr =3D devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> > > > > > -				   &altera_cvp_ops, conf);
> > > > > > -	if (!mgr) {
> > > > > > -		ret =3D -ENOMEM;
> > > > > > +	mgr =3D fpga_mgr_register(&pdev->dev, conf->mgr_name,
> > > > > > +				&altera_cvp_ops, conf);
> > > > > > +	if (IS_ERR(mgr)) {
> > > > > > +		ret =3D PTR_ERR(mgr);
> > > > > >   		goto err_unmap;
> > > > > >   	}
> > > > > >   	pci_set_drvdata(pdev, mgr);
> > > > > > -	ret =3D fpga_mgr_register(mgr);
> > > > > > -	if (ret)
> > > > > > -		goto err_unmap;
> > > > > > -
> > > > > >   	return 0;
> > > > > >   err_unmap:
> > > > > > diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/al=
tera-pr-ip-
> core.c
> > > > > > index dfdf21ed34c4..17babf974852 100644
> > > > > > --- a/drivers/fpga/altera-pr-ip-core.c
> > > > > > +++ b/drivers/fpga/altera-pr-ip-core.c
> > > > > > @@ -191,11 +191,11 @@ int alt_pr_register(struct device *dev, v=
oid
> __iomem *reg_base)
> > > > > >   		(val & ALT_PR_CSR_STATUS_MSK) >>
> ALT_PR_CSR_STATUS_SFT,
> > > > > >   		(int)(val & ALT_PR_CSR_PR_START));
> > > > > > -	mgr =3D devm_fpga_mgr_create(dev, dev_name(dev),
> &alt_pr_ops, priv);
> > > > > > -	if (!mgr)
> > > > > > -		return -ENOMEM;
> > > > > > +	mgr =3D devm_fpga_mgr_register(dev, dev_name(dev),
> &alt_pr_ops, priv);
> > > > > > +	if (IS_ERR(mgr))
> > > > > > +		return PTR_ERR(mgr);
> > > > > > -	return devm_fpga_mgr_register(dev, mgr);
> > > > > > +	return 0;
> > > > > >   }
> > > > > >   EXPORT_SYMBOL_GPL(alt_pr_register);
> > > > > > diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera=
-ps-spi.c
> > > > > > index 23bfd4d1ad0f..d3f77b0312b2 100644
> > > > > > --- a/drivers/fpga/altera-ps-spi.c
> > > > > > +++ b/drivers/fpga/altera-ps-spi.c
> > > > > > @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_dev=
ice
> *spi)
> > > > > >   	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
> > > > > >   		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
> > > > > > -	mgr =3D devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> > > > > > -				   &altera_ps_ops, conf);
> > > > > > -	if (!mgr)
> > > > > > -		return -ENOMEM;
> > > > > > +	mgr =3D devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
> > > > > > +				     &altera_ps_ops, conf);
> > > > > > +	if (IS_ERR(mgr))
> > > > > > +		return PTR_ERR(mgr);
> > > > > > -	return devm_fpga_mgr_register(&spi->dev, mgr);
> > > > > > +	return 0;
> > > > > >   }
> > > > > >   static const struct spi_device_id altera_ps_spi_ids[] =3D {
> > > > > > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-=
mgr.c
> > > > > > index d5861d13b306..1b93bc292dbe 100644
> > > > > > --- a/drivers/fpga/dfl-fme-mgr.c
> > > > > > +++ b/drivers/fpga/dfl-fme-mgr.c
> > > > > > @@ -264,14 +264,6 @@ static u64 fme_mgr_status(struct
> fpga_manager *mgr)
> > > > > >   	return pr_error_to_mgr_status(priv->pr_error);
> > > > > >   }
> > > > > > -static const struct fpga_manager_ops fme_mgr_ops =3D {
> > > > > > -	.write_init =3D fme_mgr_write_init,
> > > > > > -	.write =3D fme_mgr_write,
> > > > > > -	.write_complete =3D fme_mgr_write_complete,
> > > > > > -	.state =3D fme_mgr_state,
> > > > > > -	.status =3D fme_mgr_status,
> > > > > > -};
> > > > > > -
> > > > > >   static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> > > > > >   				  struct fpga_compat_id *id)
> > > > > >   {
> > > > > > @@ -279,10 +271,34 @@ static void fme_mgr_get_compat_id(void
> __iomem *fme_pr,
> > > > > >   	id->id_h =3D readq(fme_pr + FME_PR_INTFC_ID_H);
> > > > > >   }
> > > > > > +static struct fpga_manager_ops *fme_mgr_get_ops(struct device
> *dev,
> > > > > > +						struct fme_mgr_priv
> *priv)
> > > > > > +{
> > > > > > +	struct fpga_manager_ops *ops;
> > > > > > +
> > > > > > +	ops =3D devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
> > > > > > +	if (!ops)
> > > > > > +		return NULL;
> > > > > > +
> > > > > > +	ops->compat_id =3D devm_kzalloc(dev, sizeof(struct
> fpga_compat_id),
> > > > > > +				      GFP_KERNEL);
> > > > > > +	if (!ops->compat_id)
> > > > > > +		return NULL;
> > > > > > +
> > > > > > +	fme_mgr_get_compat_id(priv->ioaddr, ops->compat_id);
> > > > > > +	ops->write_init =3D fme_mgr_write_init;
> > > > > > +	ops->write =3D fme_mgr_write;
> > > > > > +	ops->write_complete =3D fme_mgr_write_complete;
> > > > > > +	ops->state =3D fme_mgr_state;
> > > > > > +	ops->status =3D fme_mgr_status;
> > > > > > +
> > > > > > +	return ops;
> > > > > > +}
> > > What do other's think? Is it better to dynamically allocate the ops s=
tructure
> > > for users of compat_id (just one user at this time)? Or better to cre=
ate an
> > > info structure on the stack for all callers? See above for an example=
 of a
> > > dynamically allocated the ops structure.
> > >
> > > To me, using the ops structure seems more standard, and the dynamic
> allocation,
> > > while not optimal, does not require much more space or complexity tha=
n the
> static
> > > allocation. At this time it only affects one caller.
> > >
> > > Adding the info structure as a parameter to the register() functions =
adds a
> > > little more complexity to all callers, whether or not they use the dy=
namic
> > > elements of the structure.
> >
> > Looks like dfl is the only user of compat_id.
> >
> > A board specific value does not belong in a common structure, it belong=
s in
> > a board structure
> >
> > Move compat_id out of fpga-mgr.h and into dfl.h
> >
> > In dfl- you can do whatever you want.
>=20
> Agreed. You'll have to deal with DFL specific region, that directly
> accesses mgr->compat_id.
>=20
> But yes, this should move to DFL, nobody else is using it.

Actually compat_id is used for hardware compatible checking, we consider th=
is
as a common need previously. E.g. PR application can get this compat_id fro=
m
a common sysfs interface and compare it with headers of bitstream image bef=
ore
start PR. We know some hardware doesn't need this kind of checking as it ca=
n be
recovered by from bad condition easily but some hardware can't. This is why
compatible checking is important for them. In early submission of DFL, this
interface was private, but moved out later as a common one per suggestion
from community.

Currently compat_id is defined as per-region item, and in DFL, all regions =
under
the same fpga-mgr shares the same compat_id of the fpga-mgr. If we really w=
ant
to remove compat_id from fpga-region and fpga-mgr data structure, then we
may need to add new ops to fpga-mgr / region to get compat_id (dfl provides
those callbacks, and move compact_id into private data). But I am not sure =
if
we really have to do this, if anything just let me know.

Thanks
Hao

>=20
> - Moritz
