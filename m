Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C90292317
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Oct 2020 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgJSHqi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Oct 2020 03:46:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:10216 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbgJSHqi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Oct 2020 03:46:38 -0400
IronPort-SDR: UlbFDyrXSv0Shkg4nWZAKkitqjZNddsmvwujIG9DjxpNTMKspt9rvmShkSYoBqIUCBh6iKuz/a
 ouAGIkqi27CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="251678793"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="251678793"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 00:46:35 -0700
IronPort-SDR: ltY32pMtSAuVqvxwyjtb6jVlG9FxpWlV+wRGCQ5FVDU7gMjDA+s9U0XvlntxmquZIwexuSygOL
 sPkD5X9xWxvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="331816498"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 19 Oct 2020 00:46:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Oct 2020 00:46:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 19 Oct 2020 00:46:32 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 19 Oct 2020 00:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNsVj7vtaHj+tLJRyssbDerG/vIh5N+G41RKKOJv4A1zmJckNwtSMxP8hPjhSg0IgESKnk/r8hnMi7jHuUZdKYX3dO7sRmb0611Cb5qipJ3Zoz+dxhY1qQNXs45gFPpzgKcIGtoZ0TMsRLMXjclIPX6Nborj91TIy3Rl7rOxWDe8ft5zyD/LkMflTOXpOGLZ4EMBB3QgNJ35Hcl2c9ws3Rjre2m0M+Xk3/kTiu+drSUaCG1cEQhfL02CkGoWnKowkVqFBaUtLnAvWaE6jUDrGdorQCZ7+CBjgyqNTeI779xU4zKtC8C2YYQHWk3VP44oJbuS0/TXna6iGv9Mr53X1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8ru+0CKSbqWD+EysV6M4kDIgyT1V7TwDfML2OkeJy4=;
 b=S9JNwyqYwDdCkQf0WCPMeHAHRzZ1qSQ3GuwqEUjoEmJOhzLUJKwVtrJ10RvsB0HrLOCydPFTKy3QlE9hOT5JAB4a16SX1UN6pXMDhPYoD44RUfTKY9HycJV6H/AkIGoD/p/N4YWpS3Ue9nr2usL1tDgBW8HDRA8jvtNNf4Ab7spsq1NgGSEa0hbFqm/9a7nfKbjGdBgRAV3UkfX8PrhISCQ5i4FPTIz1wN0Da3ohZ5wF1TKuosDnBdpgoxzZO1dDZUjyBJeQyqhRAJsIXog9jDxUVMgCFniYkIgF/L51jbU4Aq5mS0wIR9eInNugHD2cURlxqgQcgebfUL1PXipVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8ru+0CKSbqWD+EysV6M4kDIgyT1V7TwDfML2OkeJy4=;
 b=saHZkBJr/c88pLMJsdgIcDpd/0BdDVjOFhqs9xPlx2xZaXl4bEF/YyDf6siofLi9LIr/ApOuXfkc8upEWSuY64HUztRVwOfcaAe9AEBuCjzecmKv25C0Ba5MLfEgCnxaWvQt09oIrBePgTIOsAdw5593LUG6oWbA4VX50jkCs9M=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1849.namprd11.prod.outlook.com (2603:10b6:3:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 07:46:24 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 07:46:24 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: RE: [PATCH 1/2] fpga: dfl: add driver_override support
Thread-Topic: [PATCH 1/2] fpga: dfl: add driver_override support
Thread-Index: AQHWo4Kxm/15/eINxkCeu0YtOxDSX6maaeEAgAPpd4CAADa20A==
Date:   Mon, 19 Oct 2020 07:46:23 +0000
Message-ID: <DM6PR11MB38198EB8547974F62518EA66851E0@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
In-Reply-To: <20201019040612.GA16172@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a94f352-a897-45f4-b2a1-08d8740313e7
x-ms-traffictypediagnostic: DM5PR11MB1849:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB18495B4CADA366441B6A89D7851E0@DM5PR11MB1849.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khkvcmw9bc7yhlfjYrYCrXh218GHGVqEdtV/EvbpuavbrMagGohXsvssdCBwn6KGC0f/YkNhtkb1kSjmEp/oLkYSdAOOYFAoj2SLS+yc2ciEi3hkcLf17te2YrGjWHyhQHGsM03YoR/O/ovGs+2byzCVqcMVNmTXGk6uAjh4FVvwW7DDtBkZy+ephrsDYF8yL+NeulRViRms1bLiOI8jBJ5Xv6ZjK/VT+FlXP8Gm3A5A/HGztvsSTrugvz8mKtja+S4Yri4SZ/B5u4/Y6DLRNrzVbMGSRMz5VT6sJs/XhRiUtrExQnJuXKrKGsluUhfwMR3WWVKppI1DI+kW46bORQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(53546011)(33656002)(6506007)(316002)(186003)(5660300002)(26005)(8936002)(110136005)(54906003)(478600001)(4326008)(8676002)(52536014)(86362001)(64756008)(66946007)(66446008)(55016002)(7696005)(2906002)(71200400001)(76116006)(66556008)(83380400001)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: iGYgS/hlWFW1XFn3vhz0USWzAhjuooS9odsVjhsZIl7YG7ZXqbE8jFXWzaVD975qqXzIF2Q/x4pG/Yx5dsH3gcahjSzoP0vmJe8jndgAXSJI+qm1LctGbbfrFvGB2FhR+IRvDiKZXBNepoVuFNFLQ2N30Va3nHpoFhnc4fkTn2lOPbgaH7V2/WRnT9ITVtRvwR5do0oClSbZrXQYoHaQysBA1eQnJdby6cb1I6IDr6dmMAaib0VohQT1/pzZOtJT86gTSbGVQ4v999926nOaynvA/gMDALh69mE013mBzgT3kA2NgVOjQAaFJjKu74wHXTzZjeleMzseLz556e3I8sx3i9mPCybKpBsoBeZw9LQ7vlmryi8i+US0at3BVlXVrOiywV8p3YvxnMBoRRHHcAEbTO6hzpxPxIyIedTe40+yg+yYQjnRBql8yJTxt2bjrgir5vcL3Gwf45SMok3BMWNSYGgtSeDNLGC/kphl8Prpeu6Fh4MKjHJsnpbL3GgSY7TlQGcMntB0rN4Cvru7oemyF2BfzfdfBQixto5AJpC8GXEBxE9z+mkIQnAlzb+5ASxqkYOW5AG0oDUcxKbnSyRKbMhnmET6sxGgRO+cgAQAShpXiEophDxxLg20eSJPwpepguw/XOvwv/QsACgM4w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a94f352-a897-45f4-b2a1-08d8740313e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 07:46:23.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UsCV8eV7ayk97+asr3IPAwU3zpLQ8D/774PHug7VmE03eQE+2PY8otRFZjRzkhQCJM3QDCLcsjS8oN7Hzc66Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1849
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Fri, Oct 16, 2020 at 09:21:50AM -0700, Tom Rix wrote:
> >
> > On 10/15/20 11:02 PM, Xu Yilun wrote:
> > > Add support for overriding the default matching of a dfl device to a =
dfl
> > > driver. It follows the same way that can be used for PCI and platform
> > > devices. This patch adds the 'driver_override' sysfs file.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-dfl | 28 ++++++++++++++---
> > >  drivers/fpga/dfl.c                      | 54
> ++++++++++++++++++++++++++++++++-
> > >  include/linux/dfl.h                     |  2 ++
> > >  3 files changed, 79 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl
> b/Documentation/ABI/testing/sysfs-bus-dfl
> > > index 23543be..db7e8d3 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-dfl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-dfl
> > > @@ -1,15 +1,35 @@
> > >  What:		/sys/bus/dfl/devices/dfl_dev.X/type
> > > -Date:		Aug 2020
> > > -KernelVersion:	5.10
> > > +Date:		Oct 2020
> > > +KernelVersion:	5.11
> > >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > >  Description:	Read-only. It returns type of DFL FIU of the device.
> Now DFL
> > >  		supports 2 FIU types, 0 for FME, 1 for PORT.
> > >  		Format: 0x%x
> > >
> > >  What:		/sys/bus/dfl/devices/dfl_dev.X/feature_id
> > > -Date:		Aug 2020
> > > -KernelVersion:	5.10
> > > +Date:		Oct 2020
> > > +KernelVersion:	5.11
> > >  Contact:	Xu Yilun <yilun.xu@intel.com>
> > >  Description:	Read-only. It returns feature identifier local to its D=
FL
> FIU
> > >  		type.
> > >  		Format: 0x%x
> >
> > These updates, do not match the comment.
> >
> > Consider splitting this out.
>=20
> I'm sorry it's a typo. The above code should not be changed.
>=20
> >
> > > +
> > > +What:           /sys/bus/dfl/devices/.../driver_override
> > > +Date:           Oct 2020
> > > +KernelVersion:  5.11
> > > +Contact:        Xu Yilun <yilun.xu@intel.com>
> > I am looking at description and trying to make it consistent with sysfs=
-bus-
> pci
> > > +Description:    This file allows the driver for a device to be speci=
fied.
> >
> > 'to be specified which will override the standard dfl bus feature id to=
 driver
> mapping.'
>=20
> Yes, it could be improved.
>=20
> Actually now it is the "type" and "feature id" matching, the 2 fields
> are defined for dfl_driver.id_table. In future for dfl v1, it may be
> GUID matching, which will be added to id_table. So how about we make it
> more generic:
>=20
> 'to be specified which will override the standard ID table matching.'
>=20
> >
> >
> > >  When
> > > +                specified, only a driver with a name matching the va=
lue written
> > > +                to driver_override will have an opportunity to bind =
to the
> > > +                device. The override is specified by writing a strin=
g to the
> > > +                driver_override file (echo dfl-uio-pdev > driver_ove=
rride) and
> > > +                may be cleared with an empty string (echo > driver_o=
verride).
> > > +                This returns the device to standard matching rules b=
inding.
> > > +                Writing to driver_override does not automatically un=
bind the
> > > +                device from its current driver or make any attempt t=
o
> > > +                automatically load the specified driver.  If no driv=
er with a
> > > +                matching name is currently loaded in the kernel, the=
 device
> > > +                will not bind to any driver.  This also allows devic=
es to
> > > +                opt-out of driver binding using a driver_override na=
me such as
> > > +                "none".  Only a single driver may be specified in th=
e override,
> > > +                there is no support for parsing delimiters.
> > > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > > index 511b20f..bc35750 100644
> > > --- a/drivers/fpga/dfl.c
> > > +++ b/drivers/fpga/dfl.c
> > > @@ -262,6 +262,10 @@ static int dfl_bus_match(struct device *dev,
> struct device_driver *drv)
> > >  	struct dfl_driver *ddrv =3D to_dfl_drv(drv);
> > >  	const struct dfl_device_id *id_entry;
> > >
> > > +	/* When driver_override is set, only bind to the matching driver */
> > > +	if (ddev->driver_override)
> > > +		return !strcmp(ddev->driver_override, drv->name);
> > > +
> > >  	id_entry =3D ddrv->id_table;
> > >  	if (id_entry) {
> > >  		while (id_entry->feature_id) {
> > > @@ -303,6 +307,53 @@ static int dfl_bus_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> > >  			      ddev->type, ddev->feature_id);
> > >  }
> > >
> >
> > I am looking at other implementations of driver_override* and looking f=
or
> consistency.
> >
> > > +static ssize_t driver_override_show(struct device *dev,
> > > +				    struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> > > +	ssize_t len;
> > > +
> > > +	device_lock(dev);
> > > +	len =3D sprintf(buf, "%s\n", ddev->driver_override);
> > len =3D snprintf(buf, PAGE_SIZE ...
>=20
> It is good to me.
>=20
> Some bus drivers use snprintf, some use sprintf.
>=20
> I think it is reasonable snprintf is used here, unlike %d, %u ... it is
> uncertain for the output size of %s.

you limited the size < a page in store function for driver_override?

Hao

>=20
> > > +	device_unlock(dev);
> > > +	return len;
> > > +}
> > > +
> > > +static ssize_t driver_override_store(struct device *dev,
> > > +				     struct device_attribute *attr,
> > > +				     const char *buf, size_t count)
> > > +{
> > > +	struct dfl_device *ddev =3D to_dfl_dev(dev);
> > > +	char *driver_override, *old, *cp;
> > > +
> > > +	/* We need to keep extra room for a newline */
> > > +	if (count >=3D (PAGE_SIZE - 1))
> > > +		return -EINVAL;
> > > +
> > > +	driver_override =3D kstrndup(buf, count, GFP_KERNEL);
> > > +	if (!driver_override)
> > > +		return -ENOMEM;
> > > +
> > > +	cp =3D strchr(driver_override, '\n');
> > > +	if (cp)
> > > +		*cp =3D '\0';
> > > +
> > > +	device_lock(dev);
> > > +	old =3D ddev->driver_override;
> > > +	if (strlen(driver_override)) {
> > > +		ddev->driver_override =3D driver_override;
> > > +	} else {
> > > +		kfree(driver_override);
> > > +		ddev->driver_override =3D NULL;
> > > +	}
> > > +	device_unlock(dev);
> > > +
> > > +	kfree(old);
> > > +
> > > +	return count;
> > > +}
> > > +static DEVICE_ATTR_RW(driver_override);
> > > +
> > >  static ssize_t
> > >  type_show(struct device *dev, struct device_attribute *attr, char *b=
uf)
> > >  {
> > > @@ -324,6 +375,7 @@ static DEVICE_ATTR_RO(feature_id);
> > >  static struct attribute *dfl_dev_attrs[] =3D {
> > >  	&dev_attr_type.attr,
> > >  	&dev_attr_feature_id.attr,
> > > +	&dev_attr_driver_override.attr,
> > >  	NULL,
> > >  };
> > >  ATTRIBUTE_GROUPS(dfl_dev);
> > > @@ -469,7 +521,7 @@ static int dfl_devs_add(struct
> dfl_feature_platform_data *pdata)
> > >
> > >  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module =
*owner)
> > >  {
> > > -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
> > > +	if (!dfl_drv || !dfl_drv->probe)
> >
> > id_table is still needed for the normal case.
> >
> > Instead of removing this check, could you add something like
> >
> > || (!dfl_drv->is_override && !dfl_drv->id_table)
>=20
> I don't think it is needed. Seems is_override and !id_table are duplicate=
d
> conditions for this implementation. And it may make confusing, e.g. could
> a driver been force matched when is_override is not set?
>=20
> I think we could make it simple, if the dfl driver didn't provide the
> id_table, normally it could not match any device. I think it could be
> easily understood by dfl driver developers.
>=20
>=20
> Thanks,
> Yilun
>=20
> >
> > Tom
> >
> > >  		return -EINVAL;
> > >
> > >  	dfl_drv->drv.owner =3D owner;
> > > diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> > > index 7affba2f..e1b2471 100644
> > > --- a/include/linux/dfl.h
> > > +++ b/include/linux/dfl.h
> > > @@ -32,6 +32,7 @@ enum dfl_id_type {
> > >   * @num_irqs: number of IRQs supported by this dfl device.
> > >   * @cdev: pointer to DFL FPGA container device this dfl device belon=
gs to.
> > >   * @id_entry: matched id entry in dfl driver's id table.
> > > + * @driver_override: driver name to force a match
> > >   */
> > >  struct dfl_device {
> > >  	struct device dev;
> > > @@ -43,6 +44,7 @@ struct dfl_device {
> > >  	unsigned int num_irqs;
> > >  	struct dfl_fpga_cdev *cdev;
> > >  	const struct dfl_device_id *id_entry;
> > > +	char *driver_override;
> > >  };
> > >
> > >  /**
