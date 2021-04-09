Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAFA359642
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Apr 2021 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhDIHUf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 03:20:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:28257 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhDIHUe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Apr 2021 03:20:34 -0400
IronPort-SDR: K831olBq3McxU4fN5OJkkn09JKVMScltWgEXltlVKcLgq9fQobpeT9IJm67WtNWMDxr5aJEYOq
 6WWbeV0uMLog==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="191556536"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="191556536"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 00:20:14 -0700
IronPort-SDR: qFWjlWgv9MLuFGGZ3NlQDRp5BGGLqlcfN1UROYNsySEZAex4UM0ICnhezXHg65RsLZpcqIA+S0
 lYBfhMlfNhhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="530894933"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2021 00:20:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 00:20:12 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 9 Apr 2021 00:20:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 9 Apr 2021 00:20:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 9 Apr 2021 00:20:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kglC25EDppEl79mKsk9DbPodyQJ9z5dCYeLAfRCeP15PUC5QI2qxD0Gzp9bk01W5JSlTS0bGVUZbEX6kV8dcgH2Ct16U+qs52YeTm2vzR0YHfmXFHfMsXy0HuZM4jKcNltnrNq/MiD8pVpYHvaaO+fQnBPYkTUnLEX2zTJfSW0z1vDxqPAx5FkKlWz/PfzGpbvHjy11FeuLgkq7+4fbOonltinFfYIi1H7YUEkPJohL9/VIYdpI7B4gXD5Ohg3M4RWIawhw/aELlTcrzin2lvPP3T2PhQIS5nDdMqpeEOtSrtveSEMRCb0CjWhK3SrbH/qHRVZV7cfRGMszkDv+pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyPYzzyBRaoDFyAWtbHuhqxog+5vrqSiBVxcjlFbVgo=;
 b=JxzGpGBO6XE6kLsm3uL88dHrg+X8iVljg3UOv/CqxBe2iBwyY9sePiBDaCxw01YM5sTZ2hCyCYlzH1lb9PFlcEwx1STG01vJJGO3pvMXFQ24r84mR2eSo6Q+BRA3Nd/P8aL3i16OlVFFb+t5zPPO8BRq8UW7tAcyLiB1wdPF++mz2ucyz00PGEJlHIJ9GpSQyei6rH1Llizw43AFmfDeinxb06J9Aj82Lt6GezDawuiUy7D+n/7gMYW8HSyzleoE9jZ/0Qxhw/7rPguEF0Rn8Q+lGNP25y87n9ruvv+8oWAufrXeP44VzcOei9AfBZZNaHpT47LMjo9BDW7FHZYrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyPYzzyBRaoDFyAWtbHuhqxog+5vrqSiBVxcjlFbVgo=;
 b=O4h82VtA/DgxkP7fgn2vwQDpVP8Xz/qB5H/pKNAhkexS+2CXIWxPfb8VuY3mulXue9kC4ACAvqF6DZBGL/nsSxKN7/wLSIlS7JleDJ8aJFh9+b2TZWV+BftY3L6VYvMYMdG1FGqob4KDRQiRwsNJYOLspzQiUJnxF1CDdlJ24mQ=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM4PR11MB5344.namprd11.prod.outlook.com (2603:10b6:5:393::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Fri, 9 Apr
 2021 07:20:09 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a144:5e78:8a6a:8c25%6]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 07:20:09 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     Moritz Fischer <mdf@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "russell.h.weight@linux.intel.com" <russell.h.weight@linux.intel.com>
Subject: RE: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Topic: [PATCH 2/3] fpga: dfl: Add DFL bus driver for Altera SPI Master
Thread-Index: AQHXKnapzaN+e8jiOUasbNG/fZUbfKqmp0KAgAEBK4CAAAt/AIAChFHwgAAQfwCAAAHe8IABIkcAgAAgaTCAACO1AIAADazA
Date:   Fri, 9 Apr 2021 07:20:09 +0000
Message-ID: <DM6PR11MB381916140583F3C31D66EFC385739@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-3-matthew.gerlach@linux.intel.com>
 <YGuvFYvJTMPPm2Jy@epycbox.lan>
 <alpine.DEB.2.22.394.2104060847030.208844@rhweight-WRK1>
 <YGyQdN9uS/niyFDP@epycbox.lan>
 <DM6PR11MB3819E0FC4F735C72746CE54785749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210408081152.GA2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819317A55FD7798E778EC4D85749@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210409013730.GB2713@yilunxu-OptiPlex-7050>
 <DM6PR11MB381912BD810637E0CDA1885F85739@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210409054118.GA7986@yilunxu-OptiPlex-7050>
In-Reply-To: <20210409054118.GA7986@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f93b4ec-bc57-4299-d234-08d8fb27e899
x-ms-traffictypediagnostic: DM4PR11MB5344:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR11MB53446ECE23E895BB2BD3829485739@DM4PR11MB5344.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPa3pRkeqdux5xAPfERLVUdsm75bPjHL+m0b9h3ruyzTtKzVy1+kVOvSnTKkRr0Cp4HR0AOy1bFtSzfDGed3srNH1oJ9qbHoViiTLJRYqKlpIx+Dij1JqaspC3FdvG16ZovWQuqfKkk1rlllBzKG5m+82FKjye2Wh9Xab9MOBfhudrBuQfAxM+ampnm5vgdI3YbYwRtzwQt+gkRetKkjvEFPtHPTux2h5Cq/PSyJOcx0JtKoKx0xcuwrzp+TtSLTOXSF/GSMxaVcENvoVMIg57sgaAPacM8jiuq3ZvG8PrD3y3tRupSoNOhEpdlCfD0cx4qlJT2Vj0sSm5WOphMIlLcxDNO1BC20kOptwL/F865TtHLTqSudgZye/6ctixFfolAv+1vlzX61HmNlh2IJ/xFV3XbpcWLyypA2XhS5Wyn6ZwvWNUTVtuv4Tm2bfSXi52AP7duoigU1XNV2l36zCncQKp/C2wCpytrIWByBnU4osaRH+JtaTfc7u/tjm5SiQvJkIW8/F4k2OWaYyvUZKQB2U3VTuPWtdr1wsI0NclTmsVumxxj3+KOzKROaJ4HL9wwhZuxovjoMGWRJ0Rtl157ZkHi/KR6d1e7SYfEWBivIy8WmgVkTwZIAeTP85UbNYT3g57UCQ/EhCf6wmhzcMQkS5wz3dJkjqQl3Vz8CIRZlWJSKmPiO8xB3p6aJrO/Skx9bCHZTG/9VRRGEW4icVGh3S1rHE5EYVcs157uY/pdPwjNaP1QlHm9X/dkb+jQAoifk7/ubJrhzqGGrAcBOqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(396003)(136003)(52536014)(7416002)(6862004)(5660300002)(86362001)(83380400001)(38100700001)(8936002)(4326008)(76116006)(316002)(966005)(66476007)(66446008)(478600001)(66556008)(64756008)(8676002)(26005)(9686003)(2906002)(186003)(55016002)(54906003)(33656002)(71200400001)(7696005)(66946007)(6506007)(6636002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VMGExLF54R0Z8Qy13n4WCJivh/nOqbkykrEFyW5m55l41Ksv2L3fYk2Ww2Dy?=
 =?us-ascii?Q?6/rLpESZ9uIb/1VqHk92MnzsaEX5Bq23ntNIjJitCg0qnQkB0ABDoWdyJATX?=
 =?us-ascii?Q?KWB9Y8AeSOh6JvzbzilHC2aRkP5iVqrwzoSdkyQcECzM3ibg7FOZM1VsNPPt?=
 =?us-ascii?Q?9x9gO94y+GN+/o8tI/v8XrnlZOZgbuQSvzvsAe4zxs7dEYcXj4aY2J3Ik6AW?=
 =?us-ascii?Q?7cKEMsi1sWCdGkm2AGrUb+6B4YRNKJn4Zw8Hao5/kGIlwkwnzCtZTjYIn4AT?=
 =?us-ascii?Q?W2iDnBsKE3AGc2agyFME6dgPm6krA7sQN411Q5+u82Lk3VIxJz95gpwxpgWn?=
 =?us-ascii?Q?cXJ88+6uILaAJJNtTmWyG4m/fKnl9AaOvgOj+viB+wUb9Y4wYZUcR09G6kOq?=
 =?us-ascii?Q?v1F6BzxHF6QTC6l8q8sryz69k+ZAI+Uzm3mOuZ5KnVDTiSGegueKkrk6QJu8?=
 =?us-ascii?Q?iGMreM3B1IJxjokMpvvvqqx0sS0d8mKqJ0icxLv5cqPgcrnqmQbO/IdOhE0l?=
 =?us-ascii?Q?U+rE/1ULvDD1vrB0pTL7o098Vo0BXoO1GN1eHkSJh5JBfDHp2j5YGiiN+Ro6?=
 =?us-ascii?Q?70bAA5hd3Yjlp798AnG3GCBbDfZZyGbOATTDomlKor4IokcGsglwP5utW7Yu?=
 =?us-ascii?Q?jSqiNh7Yw0yO7gYGBOy9JpmvqvGQu4qqhji8nMC7fRaU9B2GTmxSyYZq0dcw?=
 =?us-ascii?Q?guBLYmpzm/pL6Z2g2uwZyWz0MDh+WYpdrvcC4j8H+V8yklDj2rWjE6TL0QFo?=
 =?us-ascii?Q?DBzy7Tm6HRpxy7V2S7kjDCl652CfIZkr/Fp5J4e1AfVKqbJoJCcCspFNErpn?=
 =?us-ascii?Q?qU8EoaZlVjXjCXfYPWHtaFleSBeeJdtOqd5eR2M0t/A5wcblU5cNzOAH4QwU?=
 =?us-ascii?Q?7Ybnv3JnnVYDdJOVc642JMIs/IPC+zkQwoNazyVHjDDlRKee6gmIExDl64Ki?=
 =?us-ascii?Q?TXoxF4rkOEQBWSNAc4xcG1qjvKrtzZ/TeKYliUfN6pgGFlHbJP77OA6ovAg9?=
 =?us-ascii?Q?8Eh+szPqf1dGM3jwDzHw/xCuNsiYMlG4S0dYpwi9YjgbA4o5xAjPgqSGu7vK?=
 =?us-ascii?Q?ZtInBPdwB8/ZjqU7iBOOeSWUtkCdxyALOhdOaO92giRyn63YU0al2oPXJbx+?=
 =?us-ascii?Q?nTmX88Y03waqlh/2kGR9ZpJFct+B+nplBJkpo3QVE0fa+YINKSkPft865KQj?=
 =?us-ascii?Q?taBBgVFdmKiN7ZDqRqoHqS74erRijjJVi0oZP5wQR9WvtXEL9hDdarJQnpk3?=
 =?us-ascii?Q?qvZ3fREKqm1Vfh3/jZOdzVkfdOIJDANkJ3BR/+7iqEH+FEPw0MNiuydFGZ8N?=
 =?us-ascii?Q?ibg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f93b4ec-bc57-4299-d234-08d8fb27e899
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 07:20:09.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFQQwLPV82qAvOLyBpQaiLpsJjKV0Pv7Q9P0Wr+uAxV2y7XZcWWAvyaVAJYLwrnim+bmERvm9hbMxmQth+eHSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5344
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Fri, Apr 09, 2021 at 12:02:47PM +0800, Wu, Hao wrote:
> > > > > > > > > > +
> > > > > > > > > > +static void dfl_spi_altera_remove(struct dfl_device *d=
fl_dev)
> > > > > > > > > > +{
> > > > > > > > > > +struct dfl_altera_spi *aspi =3D dev_get_drvdata(&dfl_d=
ev->dev);
> > > > > > > > > > +
> > > > > > > > > > +platform_device_unregister(aspi->altr_spi);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +#define FME_FEATURE_ID_MAX10_SPI        0xe
> > > > > > > > > > +
> > > > > > > > > > +static const struct dfl_device_id dfl_spi_altera_ids[]=
 =3D {
> > > > > > > > > > +{ FME_ID, FME_FEATURE_ID_MAX10_SPI },
> > > > > > > > > > +{ }
> > > > > > > > > > +};
> > > > > > > > >
> > > > > > > > > Maybe you can extend the Altera SPI driver with this part=
?
> > > > > > > >
> > > > > > > > The file, drivers/spi/spi-altera.c, already has platform MO=
DULE_
> > > related
> > > > > > > > code.  Wouldn't moving this code to that file produce confl=
icts?
> > > > > > >
> > > > > > > I've seen other drivers support multiple busses, so it should=
 be
> > > > > > > possible, there might be nuances I'm missing in my brief look=
 at this,
> > > > > > > though.
> > > > > > >
> > > > > > > I think one of them would be MODULE_DEVICE_TABLE(platform, ..=
.)
> > > > > > > and the other one MODULE_DEVICE_TABLE(dfl, ...)
> > > > > > >
> > > > > > > See drivers/i2c/busses/i2c-designware-platdrv.c for an exampl=
e
> (though
> > > > > > > they might be guarding against what you describe with CONFIG_=
OF vs
> > > > > > > CONFIG_ACPI)
> > > > > > >
> > > > > > > If that doesn't work we could split it up into
> > > > > > >
> > > > > > > altera-spi-plat.c and altera-spi-dfl.c and altera-spi-core.c
> > > > > > > or something of that sort?
> > > > > > >
> > > > > > > My point being, now that we have a bus, let's use it and deve=
lop
> drivers
> > > > > > > according to the Linux device model where possible :)
> > > > > >
> > > > > > Agree. This does make sense from my side too. DFL core provides=
 the
> > > > > mechanism
> > > > > > to enumerate different IPs on FPGA, but each function driver ne=
eds to
> go
> > > to
> > > > > > related subsystem for review.  : )
> > > > > >
> > > > > > I understand that for FPGA case, it may have some additional lo=
gics for
> > > specific
> > > > > > purposes based on common altera spi master IP, then additional =
code
> for
> > > > >
> > > > > I'm wondering if the additional logics are extensions for common =
spi-
> altera.
> > > Like
> > > > > the
> > > > > SPI_CORE_PARAMETER register, it is not within the register space =
of
> > > > > spi-altera,
> > > > >
> > > > >
> > > > >   |   |      +-------------+
> > > > >   |DFL|------| +--------+  |
> > > > >   |BUS|      | |SPI CORE|  |
> > > > >   |   |      | |PARAM   |  |
> > > > >   |   |      | +--------+  |
> > > > >   |   |      |             |
> > > > >   |   |      | +--------+  |   +-------+
> > > > >              | |Indirect|  |   |spi    |
> > > > >              | |access  +--+---|altera |
> > > > >              | |master  |  |   +-------+
> > > > >              | +--------+  |
> > > > >              +-------------+
> > > > > > a specific product still can be put into altera-spi-xxxx.c or a=
ltera-spi-dfl-
> > > xxxx.c
> > > > >
> > > > > So is it proper we integrate this feature into spi-altera? Previo=
usly
> > > > > we have merged the dfl-n3000-nios, its spi part is very similar a=
s
> > > > > this driver. The dfl-n3000-nios make the spi-altera as a sub devi=
ce.
> > > > > Could we borrow the idea, or could we just integrate this driver =
in
> > > > > dfl-n3000-nios?
> > > >
> > > > Looks like those are enhancements of the IP. They can be applied ev=
en
> > >
> > > I don't think the extra registers are the enhancement of the IP. They
> > > are not part of the IP because they are not within the IP's register
> > > space. They are like some external way of describing the IP like
> > > Devicetree or ACPI.
> >
> > Why adding new registers can't be consider as enhancement, those
> > changes serve the original IP and make it better, right? small mmio
> > footprint and parameter registers?
> >
> > >
> > > > other buses are used, not only for DFL, like PCI device or platform=
 device,
> > > > right? then why not put related code together with the original IP?
> > >
> > > The code of devicetree or ACPI parsing are integrated in the IP drive=
rs,
> > > but for this case, it may not be proper for now, cause this style is =
not
> > > formally introduced by any standard. IP specific parameters descripti=
on
> > > are not within the scope of DFL now.
> >
> > Not sure if I get your point, but it's possible that we add some enhanc=
ements
> > to one IP then driver could be simplified and doesn't need devicetree a=
ny more.
> > For sure, it's IP specific thing, not the scope of DFL.
> >
> > Then things become this: extension to IP to allow this IP to be used wi=
thout
> > device tree, so that this IP can be used in DFL or PCI or other buses w=
ithout
> > device tree?
>=20
> It's good to extend an IP, but it needs a published SPEC and stable
> register interfaces. For now, the spi-altera driver conforms to the
> "SPI Core" chapter of the following spec:
>=20
> https://www.intel.com/content/www/us/en/programmable/documentation/sf
> o1400787952932.html
>=20
> There is no info about the core parameter register and this specific
> indirect access bus. That's why I don't see these additional parts as
> the enhancements to spi-altera. This DFL feature is like a wrapper for
> the spi-altera sub device.

It really doesn't matter, even if you consider this as an new IP, it's stil=
l a SPI
Master, it's driver still need to be reviewed in drivers/spi subsystem. The
worst case is that we need to write a new spi-xxx.c driver, that's it.

From DFL part, DFL only can enumerate the common hardware resources,
but no good way to help thing like this, specific IP parameters (which hand=
le
by devicetree in platform driver). So for some IPs , they still need some
extensions to avoid such dependency (on device tree for parameters). I gues=
s
we may see more similar cases in the future.

Anyway, I think we reached agreement that for device drivers on DFL bus, it
needs to be reviewed in its own subsystem. : )

Thanks
Hao

>=20
> Thanks
> Yilun
