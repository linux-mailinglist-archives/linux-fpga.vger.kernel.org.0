Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF09B219D4B
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 12:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGIKO3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 06:14:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:21900 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgGIKOY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 Jul 2020 06:14:24 -0400
IronPort-SDR: jKjKQKijU88SU4nWFA2ZN4xxp8G4rNxUbGxFuSGmZhTqJtoK7Wr6pBNN3cwarCobs860IMazLQ
 O8WWlfu0Pz1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="136195882"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="136195882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 03:14:21 -0700
IronPort-SDR: 2e1UV1lYBoHM0FE94X48mHA7nqMvdq5n6m0VjfoURsaQrk0w8bWy83iEV6Mr7N9qPevMtWVJtH
 X4gsSfRpBzjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="457854466"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2020 03:14:21 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 03:14:20 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 03:14:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 03:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJa8sE6d/64mfcJPbbLX1l31X/Ns1VJ2sTyUL7c2MFtcl0xybI+auIvjR5SdltiZydhSB3owJAbm/oBY8dedPmqv9LfNuum0r7fGSfItKFDvU9YiRFHki9nhTKIiKyO2cs5P/08PvtHtU7YeKDFJsMTrMZvshM3lpV4k150/J3zS3VHXDdL6yp/yx+RaucMeQ4dMIYDOtrHTjquXNLR32KAUsumeTePms1EfuB+UPmwCrVDS3PQvrnF+GVLT1oXZYcGfqdE3Tr9u7FBz1tQPe4WBrSm4v62Wc0BLKPZel8umVNE0vyI5mY8Pnrt4I3tLRKFyMJsph5TY7VBOWziJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTklAgqCGmi/DoH1uFoBiE3CNy6qOx4AD3JLj/CN/Ew=;
 b=Zc9U91T4fW0VYj3yjdcaaVuIxOby8TolZngmiWPFp7cdl4k5PTUlGSA1TYfmfWlezCRc5/EDwGOc7O1aoNUxLavIZuFPCXXTwD6YLP/pRz7xu2CyehtHHAu16zvclEZ59h4d4/0zxIlCMdjCeig5e7NFk97/+SimpJDU3TBUteeNeZiFuMHpZPmb/4Z09aBt5hi5eYpbF4mFA5Ip3z7WNQyBOZyP65QdSRpTg4A76UMVC+cU9On1P2Q1ffsaSvCJ6LNjg5C8iPK7zkSKIbtdWTS3U58hdXTdBHUqKp79AztDO8yULvFuPBwKSA67hxpqV0yq0pcptg/QOwVbkqldpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTklAgqCGmi/DoH1uFoBiE3CNy6qOx4AD3JLj/CN/Ew=;
 b=CLcNAi0lihaB+I+exyepCVaLIdjtyS1FhxmGP0DWSmqZuVraXHrns5izbOxfnMrscwVdz2KzslFzaHxwBvcmGYUQj3fyyQvevK9sXbfUuLv6xAkJloGReqD/M1O+fjM1EUEJXV5dyWbPhhu0dJhh3a9J5R4FojrGva6m0TNR2I8=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM5PR11MB1770.namprd11.prod.outlook.com (2603:10b6:3:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Thu, 9 Jul
 2020 10:14:17 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3153.031; Thu, 9 Jul 2020
 10:14:17 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Thread-Topic: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Thread-Index: AQHWVcomDnRuf5Ios0uozSMTJLBb7aj+8y7ggAAJzICAAAjeAA==
Date:   Thu, 9 Jul 2020 10:14:16 +0000
Message-ID: <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200709093527.GA32541@yilunxu-OptiPlex-7050>
In-Reply-To: <20200709093527.GA32541@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb6b1101-420b-4b8a-f134-08d823f0d67d
x-ms-traffictypediagnostic: DM5PR11MB1770:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1770F1A275D8EC8FC4ED2E5D85640@DM5PR11MB1770.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5pk8EBfNpkUr06ALKIJhpNuiH37JZFeSYIpms2TBG3bT0FVU+A40EyTvjC9+8V9SMvOcW2pguyrulJOBnXB4A53vPm9UXPFx3iVex9D0mptxf0koyq3JWaCrv8JiSzkyWsAorGxPB8H4OJNDHCWLOruaBuG51Y+4IPlPnEoxy1/anAbt/ikJyusBypfYK0nlGCNyV2ROxdvuastnmSGyv0YPEaSRxtuDb+rkLT8ecxcN5niuQ3hNB3b07j13+PjEYRciBkyZ+pRtbAz8eY+3wUQD2hLXw1zxtaKdaxq8fT3jd9mPbpPYxgJy/v2QrakqbjAiJLOK87xoaJzLeqmK0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(54906003)(9686003)(7696005)(86362001)(186003)(55016002)(6636002)(71200400001)(6862004)(33656002)(66476007)(5660300002)(4326008)(66446008)(66556008)(76116006)(64756008)(6506007)(66946007)(2906002)(478600001)(52536014)(26005)(316002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jT8oKyXOYl77DH/0ZgVGidV5cpGTAPkcwjH3qRMtKDrzKIG7UXpDJw7BrA5PHhDnbEsWwsv7vbVx0ssT5yF0QeZ+hEMahgKFt7MLgFBfJLFSjEe0He7o6k6KkzpKWSCfBm17CaVyrC7xfv77ktvyzpL88oDh0gm+mei9oUFOtWxGTGSulu6toK7/DjoPgAalRvH52KStAq5F6ynVGZg7eTbB0GU/PRMU/UsjQtM7CBTzrsdPBmvGHVr/4aA44/V/WVmnFuLy6WC+B606gLV/EldgTLsgLXvbwNLw51MZBqSOaAim12EhI+YrcJFdf3nb0BS4jvbEf5YA9EnmyW6VHVWwKcz2Vzjszz7deaVQ7JpQelvW/r3h97AM56cOER3hEgF2ihE79Y7UoISE7VPiLPLREp/AcKXdROjvpxK9x32w+cmX2QPjt3ymFvINTeVoOSfvdoS52byuzzaXmT+HVXFU8VUXyuDqlV0vpZWtB5ICX0641DPsmsBVtmSvGsu1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6b1101-420b-4b8a-f134-08d823f0d67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 10:14:16.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtlgWAAuIhJ6sLzAm9J+vscVDsqLaL14isVzmXw8YuUaenRl+H7VwplFht66Q2rGYVRFQ1lCD4nTRa1BiV75OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1770
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
> > > Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N30=
00
> > >
> > > Add PCIe Device ID for Intel FPGA PAC N3000.
> > >
> > > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > ---
> > >  drivers/fpga/dfl-pci.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > index 73b5153..824aecf 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev=
)
> > >  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
> > >  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
> > >  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
> > > +#define PCIE_DEVICE_ID_PF_PAC_N3000 0x0B30
> >
> > Should we drop _PF_ here? and also do you want _INTEL_ here?
>=20
> I think we could keep _PF_, also there is no need to support VF of pac
> n3000 in product now, but it does exist (ID: 0x0b31).
>=20
> And add _INTEL_ is good to me.
>=20
> Then how about this one:
>   #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30

I am just considering the alignment with ids defined in include/linux/pci_i=
ds.h
So drop _PF_ before _INTEL_ would be better? : )

Thanks
Hao
