Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898FA23D732
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Aug 2020 09:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgHFHMQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Aug 2020 03:12:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:1221 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbgHFHLx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 6 Aug 2020 03:11:53 -0400
IronPort-SDR: Na2SoKLRMIkgEN3L7n3Wghr+3FNHMHrP4SOKtzjQ7dT0MQ59fCc4PB5mwwvBiY2SJV5y6s9yj7
 FEENRgDSZRZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150485878"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="150485878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 00:11:16 -0700
IronPort-SDR: aJdL+AtRMUGyrLzZ2ojIWp7WH8WVU/EyZ2u3dDK5kTFencTga7qmxYMUbb/uoGpUR3QVS2LUBq
 f5DQGrEK6jBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="467749531"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2020 00:11:16 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 00:11:16 -0700
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Aug 2020 00:11:16 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX115.amr.corp.intel.com (10.22.240.11) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Aug 2020 00:11:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Aug 2020 00:11:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jV+LJzo9msQ9sfJSORm2Dji26dyE4xlfuaHCdACbsB0f0BfoW8zxugP0JrtAuRKbh0YH48Ythk+OV5H6AHw6B1ZSVd353cWPBP4L60Qwfv8CJHGVjaAYjiXAYfqN9xCAu4e3sH9DFnQFoZushMtbxwb0uZJ9eE3YKruBPDymick+m4gVNC8T9zF8SHcuTwWJjohlWT1z52FmYzZErozcnKVhnARnxXKH79Nks6MRm9AMVGp1lHQG1H+r17RUVBRbsL5dy7xcyyPEm8iDVmAH1Bk8tQj7HcLY8XiQfhOyd1nJ8Pe1WWxLtB/uu5rXzh3ajCnWjztvE19C2It+T/ObJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AcVd2QVMhQ+q/PtkP/POKGTqm55siO9yPSn78E2z9M=;
 b=kBgzr5ibwZ+wMGQDXLKIhYOW08sTTXbSsO/9kge0QCPLoyR4fFHT3m9iOSOw/ZeBRWimhVJ6c2cvDabeK/ppQw3cBeKSgzwWkcn9RytMa5fnPgKXxhiT8Ga2byF9BDt6nlY4lACvs/VObow7/lAJeMuOrVbPGFMne0yweX+yjfTUMWspAVvt20K2f2NHb9TrFXtOElPHCbIyPPJ8JCPoXfak+Xw3KNRa/8FaRt1sQBCDnPHBKz4wTGYnTESzenm1XRdoLdNIehNRkMaOni/6rfT6V66rFzhvmk5IspINe9QyjGFe+kEcNlTu92c6Rnlmf573YnWbN5ZZaYB4BTLlMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AcVd2QVMhQ+q/PtkP/POKGTqm55siO9yPSn78E2z9M=;
 b=Y6mpNRSdgifdBE/mEF30dI6q/divIxG0G3Q66foXqZ0qZU/a9twUegSnVlvehDL81JVRTMhXLURaN7669Vua+awNkgaGlfdgHiwI48IvGA5XJpmEimjGSkC8S6OmMXEM9jDZciZ2s0gHr73RcpQJiOwWMMRU7FD4Udad4qnzW7Q=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3547.namprd11.prod.outlook.com (2603:10b6:5:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Thu, 6 Aug
 2020 07:11:14 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3239.023; Thu, 6 Aug 2020
 07:11:14 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL
  devices
Thread-Topic: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL
  devices
Thread-Index: AQHWa7gKHPA4kjNeIEyhNYURQcBeeKkqmtZA
Date:   Thu, 6 Aug 2020 07:11:14 +0000
Message-ID: <DM6PR11MB3819D5CFD0A46DCE02C9EF1A85480@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-4-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38194B629A3DC70FC0E8A010854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200806060257.GB7179@yilunxu-OptiPlex-7050>
In-Reply-To: <20200806060257.GB7179@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31662033-03db-447b-f17a-08d839d7e80d
x-ms-traffictypediagnostic: DM6PR11MB3547:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3547EB769C08F7EB4D302B2A85480@DM6PR11MB3547.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBUECcOPRGOXMA41PVShk/zZUbLG2Zn6dCCaWjdIyixbWkG6K/8MNHWnynl5/4TlT7oLhYE0Jih4pa+7pWcoIPhMwPVRCAqOBmXYm8MzIkF9T7VIoYwguqygCcExyJfGXG2aD8dy4hSbrJEv3HcQ8CchaPQEOy2fO0ALssep+yUgvhh7TDNLLkbQExX0rjWsHdYK5KAO7qfT19DcLWnouPc1eSZ/VeiMHP2ynSmC/k/M1ROMEliOvYDGLsVY8a1ko5XMqoaPdc1pXi7+Qo0a6enZNyIafIyPP3llTYmiUr9cqqGrGtMbGTG1QPeM++x8bMlPatssqxUv4Grn9MqImA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(86362001)(54906003)(2906002)(8676002)(33656002)(83380400001)(71200400001)(316002)(66556008)(6506007)(5660300002)(64756008)(52536014)(6636002)(4326008)(76116006)(186003)(66946007)(26005)(66476007)(6862004)(9686003)(7696005)(8936002)(478600001)(55016002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ECezboYGnnDUQabHXGnq4AAtLsXydn8cTQXyexCqoNyA6Ye2SIB5KMWwXjPFejgYrLrZ8eo465xpR2tDWaF7kgnhKSwPudCSJKiZOYntBwWpMFPO/0ddnPnwpAXfs76yHTufJlisbrpYe/H3CFUXWLrBy6fz3I30xFCfEyZKfu6lgVJDzuaDejshzc81dMDJoiRQ3BP1kVGb8h8CXjA1c99+BaKLdMVfoPjo0RSXT/BG8iNjE8sQ1qozqcHyPCS2NI/j8O3b7kyBq4AtNXDgwWCYs9YBJW/uHLTmk3W1pVRmTOju7/dGAadt+THC/wazTypZ4pDnBoNihol75itRxOBUPGd505gIlVgymxXbd7k8cJmiviYAA1mA4yMDcS1NQDRJctNswsoYFyOxw4+8PyJyUM/7FLnX+c7AdGyHC0rn5dcxJfRicRapu6LGvvkvc2ya40FfYA1N+bKwOKTT8sC4XzuQllqdONTWSCeGADmbpWRIO4/cbVPBoEasBudTEAfQEl46U5ADzdyTG2IdWOv2ugWc7VFYak+8Tu3ZwWEsor8GfmcqqeL9n+VJrE5W9JuxTCjwzJHl0b2gl7FWx2mz/VedumRt8VGKSoodBhZPNba6zcMDPmj9cvkrbemOnRYnxmJehSNHol7QnZ1/bQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31662033-03db-447b-f17a-08d839d7e80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 07:11:14.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAZF7lam+gBu23CDO9vvyI/cRbLzSGG0gDX230oo5JEH92QDpCO5Cg752Uto96p7yeBx4QPe236NMsEOdF2WnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3547
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env
> *env)
> > > +{
> > > +struct dfl_device *ddev =3D to_dfl_dev(dev);
> > > +
> > > +return add_uevent_var(env, "MODALIAS=3Ddfl:t%08Xf%04X",
> > > +      ddev->type, ddev->feature_id);
> >
> > Then we only print 12bit of feature_id will be enough?
> > should we make type shorter as well as feature id?
>=20
> I could envision that we need a struct
>=20
>  struct dfl_feature_id {
> 	u16 id: 12;
>  }
>=20
> for it.
>=20
> But it seems more complex and I didn't see the benifit. We don't have to
> worry about the invalid values cause we parse all the ddev->feature_id in
> dfl driver, and ensures it will not be larger than 12bit value.

Ideally type is only 4bits per spec, but looks like it's adding more zero b=
efore
the type value, and also the feature id. This may not be a real problem, bu=
t
may look a little wired, isn't it?

>=20
> > And do you think if we should add a new field for dfl version?
>=20
> I think it may not be necessary now. If we support dfl v1 in future, we
> still could try to check uuid first, then fall back to type &
> feature_id.

I think it's all about the uevent and it's user, and for users, they may ha=
ve to=20
deal with different versions, right? As you mentioned, if the event will be
different format for v1 and it's not compatible with v0, anyway we need
the version sooner or later, is my understanding correct?

>=20
> Do you have any idea for the potential usage of dfl version.
>=20

> > > +/* then add irq resource */
> > > +if (feature->nr_irqs) {
> > > +ddev->irqs =3D kcalloc(feature->nr_irqs,
> > > +     sizeof(*ddev->irqs), GFP_KERNEL);
> > > +if (!ddev->irqs) {
> > > +ret =3D -ENOMEM;
> > > +goto put_dev;
> > > +}
> > > +
> > > +for (i =3D 0; i < feature->nr_irqs; i++)
> > > +ddev->irqs[i] =3D feature->irq_ctx[i].irq;
> > > +
> > > +ddev->num_irqs =3D feature->nr_irqs;
> >
> > Do we need to consider using IORESOURCE_IRQ here as well?
>=20
> The helper functions for IORESOURCE_IRQ are all for platform_devices,
> We need to define a set of functions similar to them, I think current
> implementation is simpler, for dfl bus and drivers.

If some case that it's going to reuse some platform device driver,
then dfl_device driver will create platform device, it has to pass the mmio
and irq resources to platform device driver, how you plan to do that?

> > > +static int dfl_devs_init(struct platform_device *pdev)
> > > +{
> > > +struct dfl_feature_platform_data *pdata =3D dev_get_platdata(&pdev-
> > > >dev);
> > > +struct dfl_feature *feature;
> > > +struct dfl_device *ddev;
> > > +
> > > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> > > +if (feature->ioaddr || feature->priv)
> >
> > Why checks priv here?
>=20
> I want to make sure the dfl_device is not already created.

Is that a valid case that we expected? or sounds like error code needs=20
to be returned?

Thanks
Hao

