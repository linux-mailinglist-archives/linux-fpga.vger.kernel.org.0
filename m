Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63652D0AA8
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Dec 2020 07:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgLGGZA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Dec 2020 01:25:00 -0500
Received: from mga17.intel.com ([192.55.52.151]:40358 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgLGGZA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 7 Dec 2020 01:25:00 -0500
IronPort-SDR: URvJwa1TX+cJHXmgqAYdik6Ef+9UBY5HaWyzn3iFqUqj9jgsM2z5y090DmYT/bujd4fDsIY89/
 HY1nzlmTkYzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="153467393"
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="153467393"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 22:24:19 -0800
IronPort-SDR: SVz+sUQVY3lxt8TkYFc6+SUiOoY2h2k8ElpyjNC+rAYoucW/BYoSa728F45TCl9jBzECCAUFt7
 Di+x5r8RL36Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,398,1599548400"; 
   d="scan'208";a="347332718"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 06 Dec 2020 22:24:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 6 Dec 2020 22:24:18 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 6 Dec 2020 22:24:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 6 Dec 2020 22:24:18 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 6 Dec 2020 22:24:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhRHMP1MEJhZSJQttX4aclDbegk/eqSXp5rBxfVz4hq4aX+KsKOJ9Zkh9hLxtizIw3aUoNHLIk5bdOXfWjGBYc+GXVhNtxRgAfN8grgpUUeUqdfmv48JEaqhWYkRJZTz/b1nz9wc8R5+LrdoQDid59UfhDiLkkao6FqymkoQqF0nPPJrQIGv5ivBlKPOF9x/Wpxrqw+XCADwTJGiAzkwHaQHnSdS0dXDdQ12yVnHz9LF6MVvlVw1QKZAU9L1um/xPq9y0zbb03sx8kwe4NEjwG9OO3Zs1Ce6XRLjHVR7dbyJ0Kq8bLc5PGmBC7xHcYnfa4k/ZTHCXOKFFIzYyju9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhdatF4a+H7N8Qj6hTnit3wjOfPm37suSkHdiXO7lGc=;
 b=lgaseEQRvbDgzihvXyvJGj8oARp9K9q2MdPCzwg9vJk6MYkJ87ZyThp/ZOX1cWKcJTIk59e8W4X+SFAsYZ6JF4Gs2WphWEpgF4plGxORxbIewnvdlHMy/SDY+St7fjEYjw3SQRrc/GFl80fR+eMjP1mEwo2ftulvYQ0nwRyBHhIfoICFMvuVPt8AO7PNIdoz9+PdFdbvPX/0JoX8P8VYBj6Pmw3MKTbXKuDoZIbCx968FKZNprwVAxBypndBxPP+0gab1Y9KDy1p2l3yd3gJ6l8TdH+DAS/9TKq74bHCMzA8Glm6UvSDpkrq9L4fVhg42XgwYI/QTYNnV7klsbZZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhdatF4a+H7N8Qj6hTnit3wjOfPm37suSkHdiXO7lGc=;
 b=NQ/6bDORF2ZlgSqV0cNHSJJTHmQxgRyWzCEgR+a9nB+0jXfCEyWTWWoXJ8j+hqxH+vwaSoykNb9dmEWuQLcfRJS3lEnW3Uxg8rZS9Y/168sAp4teaxW26b8uWr7zXICyNzPJOZlX6k367su9+vDp7gHLetkTfIu+L0CfhQGisAU=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2572.namprd11.prod.outlook.com (2603:10b6:5:c8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Mon, 7 Dec
 2020 06:24:15 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 06:24:15 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: [RFC] fpga: dfl: a prototype uio driver
Thread-Topic: [RFC] fpga: dfl: a prototype uio driver
Thread-Index: AQHWzBqoeMOSBmqIPk2d4tyW9+ztfqnq/9KAgAAnaLA=
Date:   Mon, 7 Dec 2020 06:24:15 +0000
Message-ID: <DM6PR11MB38195119D03A4877E0AB3F5085CE0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201206215554.350230-1-trix@redhat.com>
 <20201207034950.GA29754@yilunxu-OptiPlex-7050>
In-Reply-To: <20201207034950.GA29754@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8e66f57-46f9-4113-1258-08d89a78b8b1
x-ms-traffictypediagnostic: DM6PR11MB2572:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2572C6D9DB627828D81DFFED85CE0@DM6PR11MB2572.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KKkiGtV97MfI3v0bIikqBU+oddTm66CzKSjWZ5xuUsyv+F3TZ+7yYq1i7tELFEHxL+jBmkxRHjCLgLlavvaOABwzrMjOFwRNwaNyl/Waez16nZTjrVgLrjtSlUUCno+f70DJgZdvFBuk4ZuRaWDcS4RbyAgcCWle3nKs/L2huQZ8VQwlv1mptxIA0AskqSnSujmK2DrkKrQ+Byfld0sR9aXbxJKxCbE6ViSHzXE/y2I016AI69xzS3q4CuifZ8xNAAJSl1xSBGU3vjDWhRJA40TLeJIaeOsKMnXCI066rJCIwOVmBHl2WfIo/3iulELWVNkHkjoTnjPzikqdDeI5paLZfKMoP9NQY0hDGqUAi/9fUWT2okhBhsRyU/tkCR5Ly+VR0LY73WiQdghmJiOygQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(52536014)(4326008)(6506007)(966005)(66556008)(66476007)(26005)(86362001)(64756008)(71200400001)(478600001)(55016002)(66946007)(33656002)(9686003)(186003)(76116006)(110136005)(316002)(8676002)(66446008)(8936002)(83380400001)(2906002)(5660300002)(54906003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xaSg9RGPKdhk6+/Ym8eGzGqe0UaMJRjt1sxmNKeVr8DBjdZ1A/Cqr0esgoxD?=
 =?us-ascii?Q?w8BZN27LPBj3RaQwbbTl48km/UuWy+e0Sgy6Gi9g/09Xp5J1TVtmC028INwz?=
 =?us-ascii?Q?fOHLH45Z9RQPSAxIihRycLIoQkBgZADsW4ZN/rTh2xFmj+g/oeSK7JnhgvdH?=
 =?us-ascii?Q?60h5G9U6JREJoB4pzY7mh5HvIZr4PZ+OPyapbu9p4MfT5UhfKRELSyUXZrhw?=
 =?us-ascii?Q?rRLx/7uAO5FYBvfX+va7yX+xrx4Qs9dPmZiAEE3wgXnUsAAwoMxDTrmzTdAr?=
 =?us-ascii?Q?EYPhf9nYmqCNFKMzFM7/lniQHaksPckXbZ784DwnxlhTFCaIJyWHSXgpCJA6?=
 =?us-ascii?Q?lKqvb95CBKw9KEtFjDINH/GSYXHTpRmes1CXkYpesDF1Xu0P9TMKviGsDwmx?=
 =?us-ascii?Q?k1bNFvESa9fZQkjA9Vqm8o06YE3cpDpEBvWtQS7baCArVk03e6q91x9xy4EB?=
 =?us-ascii?Q?eSTR9bHyQVcnrWXIodSwoqM/D/poaRlNRW7Hu59uBuxpsDcazGWYRneCqDAN?=
 =?us-ascii?Q?f3FcRya4vM832OKKQa6PSxYbcCEsM0fxfXgYOeZDM8VrJag4RHO2ZUv/Nhpd?=
 =?us-ascii?Q?FbkH7fS72uPzsNih9sShYiwLokhATw2NNj/oFQByMiKdFN5aiNO7k4UbA5ow?=
 =?us-ascii?Q?uMnQwsrFU4JyDSrxX/n2z6URk5uqgDyPrtRCZfq7hEeuHyWo0aIAhd/wjWG7?=
 =?us-ascii?Q?kRmNa0tMcL4m3E+LIEu2Q2XXjmxk5cczK6SxuEe8rksiza0KEMD/8DqxlCmh?=
 =?us-ascii?Q?Pa9TPYmk5q891wtS9OtOS5WVJKiLn+hqhQXX1iNSfKEzmcLTSubSfPH7kUZo?=
 =?us-ascii?Q?IKiQAMhR/MqxG9ZMw308W58mF4u7t00ZH3UmuLiouKo37uD+fBDiX+JTshuU?=
 =?us-ascii?Q?X4ylRSdzvuiuHIQ3g/u/VVcJOoApJvKS4yizZ37pF451jvkt3Kxfxl83rPdt?=
 =?us-ascii?Q?SStP/FZCQpQxecEuApCRM1nvgPK0ChcgXVyg7e/ETtE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e66f57-46f9-4113-1258-08d89a78b8b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 06:24:15.6811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NvRwBTnhTD5YSv8Kyvpze+dCPhpkj5VFFv1pj73yvOMW1cChsmC/+8QfD9nRe97NIOKm20u+RN597IS3J99PNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2572
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [RFC] fpga: dfl: a prototype uio driver
>=20
> On Sun, Dec 06, 2020 at 01:55:54PM -0800, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > >From [PATCH 0/2] UIO support for dfl devices
> > https://lore.kernel.org/linux-fpga/1602828151-24784-1-git-send-email-
> yilun.xu@intel.com/
> >
> > Here is an idea to have uio support with no driver override.
> >
> > This makes UIO the primary driver interface because every feature
> > will have one and makes the existing platform driver interface
> > secondary.  There will be a new burden for locking write access when
> > they compete.
> >
> > Example shows finding the fpga's temperture.
>=20
> Hi Tom:
>=20
> Thanks for the idea and detailed illustrate with the patch. I see it
> abandons the driver_override and expose all the DFL devices to userspace
> by UIO. I'd like to see if we could get some more comments on it.

This allows concurrent access from both userspace and kernel space driver
to the same feature device? conflicts?

Hao

>=20
> Thanks,
> Yilun
>=20
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/fpga/dfl-fme-main.c |  9 +++-
> >  drivers/fpga/dfl-uio.c      | 96 +++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/dfl.c          | 44 ++++++++++++++++-
> >  drivers/fpga/dfl.h          |  9 ++++
> >  uio.c                       | 56 ++++++++++++++++++++++
> >  5 files changed, 212 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/fpga/dfl-uio.c
> >  create mode 100644 uio.c
> >
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index 037dc4f946f0..3323e90a18c4 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -709,12 +709,18 @@ static int fme_probe(struct platform_device
> *pdev)
> >  	if (ret)
> >  		goto dev_destroy;
> >
> > -	ret =3D dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> > +	ret =3D dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
> >  	if (ret)
> >  		goto feature_uinit;
> >
> > +	ret =3D dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> > +	if (ret)
> > +		goto feature_uinit_uio;
> > +
> >  	return 0;
> >
> > +feature_uinit_uio:
> > +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
> >  feature_uinit:
> >  	dfl_fpga_dev_feature_uinit(pdev);
> >  dev_destroy:
> > @@ -726,6 +732,7 @@ exit:
> >  static int fme_remove(struct platform_device *pdev)
> >  {
> >  	dfl_fpga_dev_ops_unregister(pdev);
> > +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
> >  	dfl_fpga_dev_feature_uinit(pdev);
> >  	fme_dev_destroy(pdev);
> >
> > diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
> > new file mode 100644
> > index 000000000000..7610ee0b19dc
> > --- /dev/null
> > +++ b/drivers/fpga/dfl-uio.c
> > @@ -0,0 +1,96 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * prototype dfl uio driver
> > + *
> > + * Copyright Tom Rix 2020
> > + */
> > +#include <linux/module.h>
> > +#include "dfl.h"
> > +
> > +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *info)
> > +{
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *=
vma)
> > +{
> > +	int ret =3D -ENODEV;
> > +	return ret;
> > +}
> > +
> > +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
> > +{
> > +	int ret =3D -ENODEV;
> > +	struct dfl_feature *feature =3D container_of(info, struct dfl_feature=
,
> uio);
> > +	if (feature->dev)
> > +		mutex_lock(&feature->lock);
> > +
> > +	ret =3D 0;
> > +	return ret;
> > +}
> > +
> > +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
> > +{
> > +	int ret =3D -ENODEV;
> > +	struct dfl_feature *feature =3D container_of(info, struct dfl_feature=
,
> uio);
> > +	if (feature->dev)
> > +		mutex_unlock(&feature->lock);
> > +
> > +	ret =3D 0;
> > +	return ret;
> > +}
> > +
> > +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
> > +{
> > +	int ret =3D -ENODEV;
> > +	return ret;
> > +}
> > +
> > +int dfl_uio_add(struct dfl_feature *feature)
> > +{
> > +	struct uio_info *uio =3D &feature->uio;
> > +	struct resource *res =3D
> > +		&feature->dev->resource[feature->resource_index];
> > +	int ret =3D 0;
> > +
> > +	uio->name =3D kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
> > +	if (!uio->name) {
> > +		ret =3D -ENOMEM;
> > +		goto exit;
> > +	}
> > +
> > +	uio->version =3D "0.1";
> > +	uio->mem[0].memtype =3D UIO_MEM_PHYS;
> > +	uio->mem[0].addr =3D res->start & PAGE_MASK;
> > +	uio->mem[0].offs =3D res->start & ~PAGE_MASK;
> > +	uio->mem[0].size =3D (uio->mem[0].offs + resource_size(res)
> > +			    + PAGE_SIZE - 1) & PAGE_MASK;
> > +	/* How are nr_irqs > 1 handled ??? */
> > +	if (feature->nr_irqs =3D=3D 1)
> > +		uio->irq =3D feature->irq_ctx[0].irq;
> > +	uio->handler =3D dfl_uio_handler;
> > +	//uio->mmap =3D dfl_uio_mmap;
> > +	uio->open =3D dfl_uio_open;
> > +	uio->release =3D dfl_uio_release;
> > +	uio->irqcontrol =3D dfl_uio_irqcontrol;
> > +
> > +	ret =3D uio_register_device(&feature->dev->dev, uio);
> > +	if (ret)
> > +		goto err_register;
> > +
> > +exit:
> > +	return ret;
> > +err_register:
> > +	kfree(uio->name);
> > +	goto exit;
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_uio_add);
> > +
> > +int dfl_uio_remove(struct dfl_feature *feature)
> > +{
> > +	uio_unregister_device(&feature->uio);
> > +	kfree(feature->uio.name);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_uio_remove);
> > +
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 1305be48037d..af2cd3d1b5f6 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -603,6 +603,7 @@ static int dfl_feature_instance_init(struct
> platform_device *pdev,
> >  	}
> >
> >  	feature->ops =3D drv->ops;
> > +	mutex_init(&feature->lock);
> >
> >  	return ret;
> >  }
> > @@ -663,10 +664,51 @@ exit:
> >  }
> >  EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init);
> >
> > +int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int
> dfh_type) {
> > +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> > +	struct dfl_feature *feature;
> > +	int ret;
> > +
> > +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +		if (dfh_type =3D=3D DFH_TYPE_FIU) {
> > +			if (feature->id =3D=3D FEATURE_ID_FIU_HEADER ||
> > +			    feature->id =3D=3D FEATURE_ID_AFU)
> > +			    continue;
> > +
> > +			ret =3D dfl_uio_add(feature);
> > +			if (ret)
> > +				goto exit;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +exit:
> > +	dfl_fpga_dev_feature_uinit_uio(pdev, dfh_type);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_init_uio);
> > +
> > +int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int
> dfh_type) {
> > +	struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> >dev);
> > +	struct dfl_feature *feature;
> > +	int ret =3D 0;
> > +
> > +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +		if (dfh_type =3D=3D DFH_TYPE_FIU) {
> > +			if (feature->id =3D=3D FEATURE_ID_FIU_HEADER ||
> > +			    feature->id =3D=3D FEATURE_ID_AFU)
> > +				continue;
> > +
> > +			ret |=3D dfl_uio_remove(feature);
> > +		}
> > +	}
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(dfl_fpga_dev_feature_uinit_uio);
> > +
> >  static void dfl_chardev_uinit(void)
> >  {
> >  	int i;
> > -
> >  	for (i =3D 0; i < DFL_FPGA_DEVT_MAX; i++)
> >  		if (MAJOR(dfl_chrdevs[i].devt)) {
> >  			unregister_chrdev_region(dfl_chrdevs[i].devt,
> > diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > index a85d1cd7a130..fde0fc902d4d 100644
> > --- a/drivers/fpga/dfl.h
> > +++ b/drivers/fpga/dfl.h
> > @@ -26,6 +26,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/uuid.h>
> > +#include <linux/uio_driver.h>
> >  #include <linux/fpga/fpga-region.h>
> >
> >  /* maximum supported number of ports */
> > @@ -232,6 +233,7 @@ struct dfl_feature_irq_ctx {
> >   * struct dfl_feature - sub feature of the feature devices
> >   *
> >   * @dev: ptr to pdev of the feature device which has the sub feature.
> > + * @uio: uio interface for feature.
> >   * @id: sub feature id.
> >   * @index: unique identifier for an sub feature within the feature dev=
ice.
> >   *	   It is possible that multiply sub features with same feature id a=
re
> > @@ -248,6 +250,8 @@ struct dfl_feature_irq_ctx {
> >   */
> >  struct dfl_feature {
> >  	struct platform_device *dev;
> > +	struct uio_info uio;
> > +	struct mutex lock; /* serialize dev and uio */
> >  	u64 id;
> >  	int index;
> >  	int resource_index;
> > @@ -360,6 +364,11 @@ void dfl_fpga_dev_feature_uinit(struct
> platform_device *pdev);
> >  int dfl_fpga_dev_feature_init(struct platform_device *pdev,
> >  			      struct dfl_feature_driver *feature_drvs);
> >
> > +int dfl_fpga_dev_feature_init_uio(struct platform_device *pdev, int
> dfh_type);
> > +int dfl_fpga_dev_feature_uinit_uio(struct platform_device *pdev, int
> dfh_type);
> > +int dfl_uio_add(struct dfl_feature *feature);
> > +int dfl_uio_remove(struct dfl_feature *feature);
> > +
> >  int dfl_fpga_dev_ops_register(struct platform_device *pdev,
> >  			      const struct file_operations *fops,
> >  			      struct module *owner);
> > diff --git a/uio.c b/uio.c
> > new file mode 100644
> > index 000000000000..50210aab4822
> > --- /dev/null
> > +++ b/uio.c
> > @@ -0,0 +1,56 @@
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <stdint.h>
> > +
> > +int main()
> > +{
> > +	int fd;
> > +	uint64_t *ptr;
> > +	unsigned page_size=3Dsysconf(_SC_PAGESIZE);
> > +	struct stat sb;
> > +
> > +	/*
> > +	 * this is fid 1, thermal mgt
> > +	 * ex/
> > +	 * # cat /sys/class/hwmon/hwmon3/temp1_input
> > +	 * 39000
> > +	 */
> > +	fd =3D open("/dev/uio0", O_RDONLY|O_SYNC);
> > +	if (fd < 0) {
> > +		perror("uio open:");
> > +		return errno;
> > +	}
> > +
> > +	ptr =3D (uint64_t *) mmap(NULL, page_size, PROT_READ, MAP_SHARED,
> fd, 0);
> > +	if (!ptr) {
> > +		perror("uio mmap:");
> > +	} else {
> > +
> > +		/* from dfl-fme-main.c :
> > +		 *
> > +		 * #define FME_THERM_RDSENSOR_FMT1	0x10
> > +		 * #define FPGA_TEMPERATURE	GENMASK_ULL(6, 0)
> > +		 *
> > +		 * case hwmon_temp_input:
> > +		 * v =3D readq(feature->ioaddr +
> FME_THERM_RDSENSOR_FMT1);
> > +		 * *val =3D (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
> > +		 * break;
> > +		 */
> > +		uint64_t v =3D ptr[2];
> > +		v &=3D (1 << 6) -1;
> > +		v *=3D 1000;
> > +		printf("Temperature %d\n", v);
> > +
> > +		munmap(ptr, page_size);
> > +	}
> > +	if (close(fd))
> > +		perror("uio close:");
> > +
> > +	return errno;
> > +}
> > --
> > 2.18.4
