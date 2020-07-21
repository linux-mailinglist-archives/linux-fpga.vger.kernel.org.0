Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE8C227F26
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jul 2020 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgGULlc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jul 2020 07:41:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:5680 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgGULlb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Jul 2020 07:41:31 -0400
IronPort-SDR: LFeodUKz/mg7n+RaBZhK6Ki0TabItj7aI3G9IYDBPe5nnweaLt3oWmGhihY4vHFqL7sOFe2YPw
 02WbQ2z8ghNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="234963238"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="234963238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 04:41:30 -0700
IronPort-SDR: TxkpDLuKn1mRjpOxDk4sa/4rmD3EpO130GWtRXmaIRxuYCBAAyvflYiIyhptApujYZ6wopUuBm
 IdWYZMLnOrfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="301588655"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 21 Jul 2020 04:41:30 -0700
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jul 2020 04:41:29 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx111.amr.corp.intel.com (10.18.116.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 21 Jul 2020 04:41:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 21 Jul 2020 04:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up9QTmDcxF8/t9jYiIIkV/bddzUirOhM/3I95SMP9TE/tTsV21grb9ktN+cCLGG85bWJwVKjkM1HK+igJ5hihBP8/0el43TCK5lE2KgDuAMne0y6OLCSF0joZxOmIAlLqxtDynPzeK361Iq0xJV8/yUGG+TITOxvIOUjq59ENp60kbj6Brw0kseavbHmOohP1t6ss3AZuw9U/2lVOazjUKGfYScofcHFE6ZWJNriL2t2G20i5U8fetCCeFiWoVrca+aKDs1LiAta5NRh9bqbRZgkP+WF5Zqt/ghLE2lf72qp9oXSe4398fsH1G6iUdx0QPj1/Ofo2Qq8k7nwwAK9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBai5RVIHKYcE2nHilB5YUNnhfAYOetzZg91O39R+hU=;
 b=KNktaqv1QeOe3pxfotBwv2b9A4zVjvK0IGi4A5YYVdp/++PcrBgg+EPKsQwbk6KtC6ztL7kAYbi5QShDxnQy8CjJZT1hcQTMVBK8HIDQ4oMituytb5JC01l9h7O0qX7xtSCzheK1GDkq+FzHWmLQqgf5g2LBTNpPgNI+4wScMthw/dgcPVeFVr+4jAXCf2zl4KenEDg4r6OvmQIBV+LMhDGOH3cwv5QFfnXTp+Hs+5Lom416Xuus/pNoMfUAYhMojGMZPasSC2aphDkXvpKUZMlpYgrh0MfeqxqlN5fcWLN1azwzDkT2KJ0wsDqEhUNVwOyLLxxij0tuoFgz8rWkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBai5RVIHKYcE2nHilB5YUNnhfAYOetzZg91O39R+hU=;
 b=sR08FXN7zKU/Kz7GK3SQJjtfbCTGsJaBGlS92wYRbkhTPK37yQ1nWn+M94arq6qWQvZN9mOPwtgK4ufL2Rj3uCMGjxzsjsvd4YFksXTBwm5yumPYUiLFhCBQbvukO4pNhfkX8lfao1jQOSgkYzTal7xWG5Xz/kUCoHe3vnNskDw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4628.namprd11.prod.outlook.com (2603:10b6:5:28f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 11:41:28 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 11:41:28 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Thread-Topic: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Thread-Index: AQHWXzmp9uIumsmhBUK9nlK2uTc5gKkR25Ug
Date:   Tue, 21 Jul 2020 11:41:27 +0000
Message-ID: <DM6PR11MB381958D370FD3BF0173BBD5685780@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38195AA712F8089090695CE5857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200721083030.GG17091@yilunxu-OptiPlex-7050>
In-Reply-To: <20200721083030.GG17091@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71eaaa28-f545-4937-357b-08d82d6b0165
x-ms-traffictypediagnostic: DM6PR11MB4628:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4628D45CC69A94BC236E537D85780@DM6PR11MB4628.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: knWg+HC7/1Wcfr7eFqbYHpMUXHSkj7ks97FJLzdi829kFvCXaWOrXVaxqtPlHk7o4qboVJS4FiqyQvqjKABGJa/grZBi3sqRp76SQov7aNEy1Saa4LUifTC+VyssihNvLT+WyOKIGO1B9wmgNvn2RiqlNlJ2CdaSCyaNSOTjptDUQSTRUulNtYaYTMekUxPcAyJskb1Ca07/Xfds6nL6sb8PPHMH0T0PTN/3/lTZUUK/51+tEbsCXykCvnhE4ijKPvO6TD0a/tmQljOHIylftspIoVBvyiBo1db7GELrfjZ+9eP84lfFHiPyZv0UP0Sme+A4q2+d3/nBY9F+xbcFyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(9686003)(186003)(26005)(316002)(6862004)(6636002)(7696005)(55016002)(33656002)(6506007)(4326008)(52536014)(64756008)(8676002)(2906002)(71200400001)(8936002)(54906003)(66476007)(4744005)(5660300002)(86362001)(76116006)(66446008)(66946007)(478600001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cwDoUbe37U7csCh5/IaBKd7rMbtR+kQIkHqWKcyHgZvkhy+S1KFxu9EWuB8xYC/T8jahh7qB3W27gS3imy3lGmqmlAvFB9IvqNz2vwLB5WHTylrelhyJ8UUKM2FfC5wKtYEPj20qDBZaVh3es7Sijcowv1o3cOmn/lRWEmmd7JBcep9Pe3f3NdY3lwj429sl0uHDGqt9k/zEH5sd5JJAy2QnHssWAgJQJ+iTnsNy5124Y13eT/pklaKhrDjBSSLaW29PjruwrBuHJbT4N57kFA8xgzDn6RfayGj7kfO5lca3fDR0AAsAb36JJtQot+OwReGu0LnpfNthiQchbDl6/CyzoIvUOtwUcVnVOcH0rQ0muZIUxCW38Vg/eQs5orj675QYay5E6AOJsOR7zQASgRlTFT+FNtTyyzHTnT9MsntXZWpf/aO3MF+0fLzCkj46aM9yIcA7L0G2tRYnEdN8OQAWgC7Fs1dHKF4yvG9w+lSl2XG2RKXiKcCZ569bKXHa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eaaa28-f545-4937-357b-08d82d6b0165
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 11:41:27.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UluOILRf3FhzJzTCzSbFKH88YoEHjxWo+9x9ZPbUvAHi3A18Gl4RjCsTrlBInLh7VW6q/zbD1X9eMPTC2v9vmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4628
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > +}
> > > +
> > > +dfl_dev->type =3D feature_dev_id_type(pdev);
> > > +dfl_dev->feature_id =3D (unsigned long long)feature->id;
> > > +
> > > +dfl_dev->dev.parent  =3D &pdev->dev;
> > > +dfl_dev->dev.bus     =3D &dfl_bus_type;
> > > +dfl_dev->dev.release =3D release_dfl_dev;
> > > +dev_set_name(&dfl_dev->dev, "%s.%d", dev_name(&pdev->dev),
> > > +     feature->index);
> >
> > Or it's better to have a generic name for the device on the bus.
>=20
> mm.. It is good suggestion, we should have a unified name for dfl
> devices.
>=20
> How about ("dfl.%d.%d", pdev->id, feature->index)

It's quite difficult for people to use related information from these magic=
=20
numbers. They are not ids defined in the spec, so just dfl_dev.x with one
unique id seems to be better. If you really need to expose some id
information, maybe you can consider adding some standard sysfs entry
to all dfl_dev, I think that will be easier for users. How do you think?

Thanks
Hao
