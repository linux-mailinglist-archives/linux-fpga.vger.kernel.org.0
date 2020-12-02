Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8F2CB9E1
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 10:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbgLBJ5K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 04:57:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:25019 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388462AbgLBJ5J (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 04:57:09 -0500
IronPort-SDR: G1iMg5FlOW9xJBM7Ml1G4yQAqXX9afwDR4I9/yCchtekc9LUboObcojkIyYCiGN4oeGuOX/aqM
 omvJulFKVJJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191203562"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="191203562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 01:56:28 -0800
IronPort-SDR: xipLtQ21wLXY74r9VYCrPKpT231DoznjDz4Cs9gDAq3XM6drd5WkX6nEhO9VDCyFaafDVxJmix
 txwfPHapyOcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="549984294"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2020 01:56:28 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 01:56:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 01:56:27 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 01:56:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uo2Zznn2oTtHzGHJEWAw3yC9RI43Q7wFKkpoWIbH7YIA+AJtGs71EUU04CvquA+nkTuhkVoW+mpdbf1izPfT3EEPkxMnBRO0YhzIVro/vcpuVquLEK/7aA4n57rYQXULI3xo8J+MyD6CeHpnY+BMM5JI4vKUU/ylmz8764gScVjHQt7/rGZNqLYjB4GwB9eNlZtewabOCQ+RfDmo6zj4tvLrNfebBh8upcxTAz++8GVkUyWJmzqkmBdzg42qJ7kN+2eN1iYxj5hZ+JDB8gfijS1FsG1sLq3zNmsFi2iiCndbbYD7njGiF1g0njNWp7yAwQV+bphhBShWXaxSHYkzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFd8z6ROIilBciMKU1CbcDAQMojJQEcNEfGdd36M9AE=;
 b=fC0zpIc9l3pFyc/EkfN79c82WXBk4zwjca6OV1ZGEXjXdJ/Gh5ZNy4TtLzNgjCKdWmAHfY/NtFT5rqM03X/GSrzZD25THGm6f7vax0UbRQ5wP2/PA6aGvZXVuzb767D/3V2VTthWiu3a5tjpPRJ2D3l0XdW0YUOu5ZLQ5pV7z3BX3wRJ+yqAc62xasotD8WM9YDbOs+9yecclcKhqFR4glw60AfRisFn+/P3zhQzxg6bT5V/OCwuDKnBaVF3/BTYHo6y/Ei3vuFaLjj5sCAH+ws8rfzP286HTLN1iWDYfPPIEDxsoboTL6qwtPXyx0dK6ZQryddVHU/s9m1kr6KOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFd8z6ROIilBciMKU1CbcDAQMojJQEcNEfGdd36M9AE=;
 b=J+PXNQZaFy4tNyi6wVKJv7BI+Vk92cNvk08Sk1SiTzopVyCPYbHeiQNldbxu66Ui/IUufTJF9anNmTgZYb23vjT+Z8ARVNZAMDtYuuPf2SbKzwrojPyXJmA52clXMm6zcCP+nrNuE57BvdCsYiNwjurl6ve5G3N8LHPhBqpDsMw=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1418.namprd11.prod.outlook.com (2603:10b6:3:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 09:56:26 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::a52f:f4c:3a9d:28a5%4]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 09:56:26 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
Thread-Topic: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
Thread-Index: AQHWwnpOqjhoM37MKU6ujI2Rfo8RvKndD8WwgARhwwCAATDggIAA+WKA
Date:   Wed, 2 Dec 2020 09:56:26 +0000
Message-ID: <DM6PR11MB38191CF23533B7C1B44B56EA85F30@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com>
 <20201124155658.700976-3-matthew.gerlach@linux.intel.com>
 <DM6PR11MB38191D8C5E27E6E04B8DAA1A85F70@DM6PR11MB3819.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
 <X8aR36hGoV9SsPDw@archbook>
In-Reply-To: <X8aR36hGoV9SsPDw@archbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2422c29e-674c-4690-10e3-08d896a88896
x-ms-traffictypediagnostic: DM5PR11MB1418:
x-microsoft-antispam-prvs: <DM5PR11MB14186FAB9E34569C94A0F5C285F30@DM5PR11MB1418.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EgMdXbc8JwvkSxcxZVSWr3Bs5F+UsVBurBFCqUMniBKua2zMakLz+OOkWRD7LgSqz6WsO5OzPchPxwO+yUDPlVoUfkwkcZwdYhqqpxwt46wOZA8yYchOVP4SiiR2tmVVKV+WIwnhOHr8G3evp6VUhNeOBG4ElrSz2RoLIXpL3ReHb9LtsjBuNcZh/t7/N5HIteqtdkk8TrgIwukyzSM8vkEooe7n7eAQOcWUlu/Cc8EnGJ5Cukzlftb+tBMr5ZRW90thReghqYlCLr9cKXjULS7v+mGBShucv4eJfOsH5o3rXdCSGYyuB13L1/ZYLcD/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66556008)(33656002)(55016002)(66446008)(9686003)(64756008)(66476007)(7696005)(76116006)(478600001)(26005)(66946007)(52536014)(54906003)(86362001)(316002)(110136005)(71200400001)(8676002)(5660300002)(4326008)(2906002)(186003)(8936002)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uU7vXPgJ3JMsE2NKLgDP9tNrOpQ2qtaURbhIp4OYNxMTQM5vYMJ+u5ydg3Mi?=
 =?us-ascii?Q?o+8wF52ePdI0Fnv3W8yxTf9zg2JmRTBinY184dkxWtUw2w0JNB+30AoHWSt5?=
 =?us-ascii?Q?mKL8GRdrW2jaHI3on/5SLZ+p3Sp9iQtQnkSdkMMCMdx9DmyVe26pekt9TGW0?=
 =?us-ascii?Q?OMncfmjHoNSHRT0dYsemnIvL3jXxNXNJn+gupti+kD1cFQOBSfpIdQSfHlc8?=
 =?us-ascii?Q?Psb4sMEmoI/Kw7WILTpP9JOBolOv7uAC1t44P4bpJD6D4kcgiEHk0wz7rX+f?=
 =?us-ascii?Q?HQK2pcP1zbwWDlnAI3+omt1DYwMZeZiRW+1krNcb2BlURDIUJDtd/ND9slQr?=
 =?us-ascii?Q?AVl/RJWQs1smaZx7+aH89BDH0IbAE+/qLDMp69JwQRKjgBT+r+0NHXcb0rkV?=
 =?us-ascii?Q?tU8+RA46Afs9UzjKA0Joy6hyWgoIWWSPOrs+xEUlGq32kCo0YsfT8yJKQJ3o?=
 =?us-ascii?Q?vzVfYRV1b2br3PZmfUrzzJbFosfn1BW2xvxEKCgdPFpCOiylOl5JQbnlur6r?=
 =?us-ascii?Q?/3Qm7vBiAlz4Y4mPPsdhh5HSHUghUntUVcYiJoTGnKGIh06BX9PdCUpMgpMU?=
 =?us-ascii?Q?cA4+Dh6BTxvJ6JpduQ7LIe15r3QKfkGhTZXj3dO4NJ4IGk6PWuzdMVty4n4W?=
 =?us-ascii?Q?yJn3KBrockys8B4P5s4lokssY6if6Iek/g4idFGdljRXBi4ziLzvb4GRN1QN?=
 =?us-ascii?Q?/iGKKzGcm+iRzHV/gEuATYBIlgJa1uCjUCqi6VUXiChI5fQrwTBez6z0kEfc?=
 =?us-ascii?Q?7980VFiIwqRMI8o18+p8J9U+UtP8qvYoLtZ4Xgt95eZx48JyQx6996VVVN3a?=
 =?us-ascii?Q?ozOS3fvmqlfR4T9Z5d0y9lBBR4aGfpPAzg3oiwVbYagQRcQFyVxLNKvdBFei?=
 =?us-ascii?Q?dx3jkv9iPIAo4rDGO64pepjKlV0OxsGQ3smOS542h7xTdBYPuAsVnLLKUF0d?=
 =?us-ascii?Q?P2mnYFrBw5mM68NlXx0YIZOW3RZh+p4ikCidihPoFWk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2422c29e-674c-4690-10e3-08d896a88896
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 09:56:26.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pSO3W5z2MwDRk/3WiPoYJnszqdt7TdzQsKM9DpxXL074qOZr4ffTmes6FIbMMgYZ3COYCvunC4r+K6qznj9Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1418
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: Re: [PATCH v3 2/2] fpga: dfl: look for vendor specific capabilit=
y
>=20
> Hi Matthew,
>=20
> On Mon, Nov 30, 2020 at 04:45:20PM -0800,
> matthew.gerlach@linux.intel.com wrote:
> >
> >
> > On Sat, 28 Nov 2020, Wu, Hao wrote:
> >
> > > > Subject: [PATCH v3 2/2] fpga: dfl: look for vendor specific capabil=
ity
> > >
> > > Maybe we can change the title a little bit, what about
> > > fpga: dfl-pci: locate DFLs by PCIe vendor specific capability
> > >
> > > >
> > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > >
> > > > A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
> > > > specific capability can be used to specify the start of a
> > > > number of DFLs.
> > >
> > > A PCIe vendor specific extended capability is introduced by Intel to
> > > specify the start of a number of DFLs.
> >
> > Your suggestion is more precise.
> > >
> > >
> > > >
> > > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > ---
> > > > v3: Add text and ascii art to documentation.
> > > >     Ensure not to exceed PCIe config space in loop.
> > > >
> > > > v2: Update documentation for clarity.
> > > >     Clean up  macro names.
> > > >     Use GENMASK.
> > > >     Removed spurious blank lines.
> > > >     Changed some calls from dev_info to dev_dbg.
> > > >     Specifically check for VSEC not found, -ENODEV.
> > > >     Ensure correct pci vendor id.
> > > >     Remove check for page alignment.
> > > >     Rename find_dfl_in_cfg to find_dfls_by_vsec.
> > > >     Initialize target memory of pci_read_config_dword to invalid va=
lues
> before
> > > > use.
> > > > ---
> > > >  Documentation/fpga/dfl.rst | 25 +++++++++++
> > > >  drivers/fpga/dfl-pci.c     | 91
> +++++++++++++++++++++++++++++++++++++-
> > > >  2 files changed, 115 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rs=
t
> > > > index 0404fe6ffc74..fa0da884a818 100644
> > > > --- a/Documentation/fpga/dfl.rst
> > > > +++ b/Documentation/fpga/dfl.rst
> > > > @@ -501,6 +501,31 @@ Developer only needs to provide a sub feature
> > > > driver with matched feature id.
> > > >  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/d=
fl-
> fme-
> > > > pr.c)
> > > >  could be a reference.
> > > >
> > > > +Location of DFLs on a PCI Device
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > +There are two ways of locating DFLs on a PCI Device.  The original
> > >
> > > I found this new VSEC is only for PCIe device, correct? If so, let's =
make
> > > sure descriptions are accurate. E.g. default method for all devices
> > > and a new method for PCIe device.
> >
> > Yes, the default method can be used with PCI and PCIe device, and the
> VSEC
> > approach is PCIe, only.  Documentation can be made more precise.
> >
> > >
> > > > +method assumed the start of the first DFL to offset 0 of bar 0.
> > > > +If the first node of the DFL is an FME, then further DFLs
> > > > +in the port(s) are specified in FME header registers.
> > > > +Alternatively, a vendor specific capability structure can be used =
to
> Maybe: a vendor specific extended capability (VSEC) ...
> > > > +specify the location of all the DFLs on the device, providing flex=
ibility
> > > > +for the type of starting node in the DFL.  Intel has reserved the
> > > > +VSEC ID of 0x43 for this purpose.  The vendor specific
> > > > +data begins with a 4 byte vendor specific register for the number =
of
> DFLs
> > > > followed 4 byte
> > > > +Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Off=
set/BIR
> > > > register
> > >
> > > Do we have a defined register name here? or it's named as Offset/BIR
> register?
> > > Sounds a little wired, and I see you defined it as DFLS_RES?
> >
> > The Offset/BIR terminology is also used in the MSI-X capability structu=
re.
>=20
> Yeah, this intuitively made sense to me having worked with PCIe :)

I just feel that it's better to use the same register name defined in the c=
ode
below. So people can find matched information in both code and doc easily. =
: )

Thanks
Hao
