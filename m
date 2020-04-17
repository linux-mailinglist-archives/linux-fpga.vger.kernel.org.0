Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C5D1AD5D0
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Apr 2020 07:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDQFzo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Apr 2020 01:55:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:53911 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgDQFzo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 17 Apr 2020 01:55:44 -0400
IronPort-SDR: U9u1JU5qwqizVgMNIL2wRsjnJuJSwmn4DDQLHVZQ8Rfli1Lmn4bRghzuV3P/8h3EgUm7h2GzrO
 WpO7Ns7xcmUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 22:55:42 -0700
IronPort-SDR: iE7pmHXXcInbRzt/cr9tskj0laldmMsPhxnVV8VLiNoX0eYBo9aQsxwR6LQYdSiwZytk5aTPG9
 wRmYA+dk+Pyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="428118665"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 22:55:42 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 22:55:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 22:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUjUN+QPusQwQLGqrnRofg5NBT7bC6IZduPJ5dbOmdCd5CqNhs6VXjJofpVGBi5qNCLFqNgv4QWX4nLYliO0IOAukYUE0eEeEQ1fOQ48yw2HDcZjdR76mQiuM2ex1S27croA4Y9d4P54cvL9d17PJaFHOzhWKd8BF4gJOV7QP+OdLAY8m2WXTs1wMxaJRvO5MHe2GhtSBU9bqilSQTdWI1cZB2lpUbzCrQbOOADHwHBAzgSxKL7nGt+JAUmAd3216C26yiam0K90YjUIV6NwY3k1oHNKRGSef2sLIk8dPinaEoNSVFrW1BIc52ROvjQUrT+Ul1WbH6oBxU9OL9R41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N5i5qYQd7B6sMzkkvo075WEO5nqw0XDDkCCx36BPns=;
 b=kdN4LF0XAxtYbNQ3ariqJfzzlfRDMEP5pI7NFiBbO4n3E3UDeKxl25oi2bE/G3qZ7H+2kgtzXwsXN7B+/ybFq/9Xf8V2vVBDgI4fp5FGwd5X855tiveDJ/0MzQnuyPyPIk8w+rNGhlLP5LxeTsESewWxP+Cw4ooDnaqmwImTYpqptyB+9CoWEpmdFcPXq3DW1OjrrwHPH0/vIBHqjMZ8GtcjDCVTZEuypTyJBj5MAMCr855c9EmMDFvxVsIDza9N72WK5FiMc1tOsmwVjxYFhmuxQmVVL9opLoAp8Wn/8yDclcuTq5SLWOX7GwGwC02DQy8vfdV/E7vGidYtOukyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N5i5qYQd7B6sMzkkvo075WEO5nqw0XDDkCCx36BPns=;
 b=sCZnqzN360vVrb5AU/gidlGp6ccAipwLSlaiKPYQGozFrx1XeZTCaNvxaKZPskEHKwk2pfOHvFN6sdIX0vinZVZpP5G17cXSODvx6TC5o6DgGYfAtDuvmqcht6gA8VtkwXj8KZ+IBpJjH5Mn7NzOrbTJDraXT/w3PxVcfSWRDzc=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4027.namprd11.prod.outlook.com (2603:10b6:5:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 05:55:39 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 05:55:39 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>
CC:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhu@redhat.com" <bhu@redhat.com>
Subject: RE: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Thread-Topic: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Thread-Index: AQHWE5193+0/nQdMD0KUurSvMI7dQ6h7YzcggACVlYCAAJaugIAAEAvggAAH1QCAACpPYA==
Date:   Fri, 17 Apr 2020 05:55:39 +0000
Message-ID: <DM6PR11MB381922556FF1BB3FB550358985D90@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
 <20200417015605.GA30618@yilunxu-OptiPlex-7050>
 <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200417032132.GA25293@yilunxu-OptiPlex-7050>
In-Reply-To: <20200417032132.GA25293@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hao.wu@intel.com; 
x-originating-ip: [192.102.204.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bcebcfa-0248-4f3d-421c-08d7e293f548
x-ms-traffictypediagnostic: DM6PR11MB4027:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4027020DA1F954F6FAFCA9F985D90@DM6PR11MB4027.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(376002)(346002)(136003)(366004)(396003)(26005)(2906002)(6862004)(4326008)(86362001)(81156014)(186003)(8936002)(54906003)(55016002)(316002)(8676002)(9686003)(6636002)(5660300002)(4744005)(6506007)(71200400001)(478600001)(7696005)(52536014)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mv3cpmJyoisVAGQmzlaMykX8gmb59SsxMzKx7Y7y6wHnIhunw5PITAWyTC5+I7+LuAQgCvvKXpaiWLIV18xB5y+Sod5+RSoudWbc2q3i65BgFtX6BTKF1HvYAH728mdrhLMULXI89t+cXmtneYDfSYaKjdzmguAFDz21i9xY0F4uKMn/vDoY1ZOSZFukvKbhHwCAbROWA8g9jmfjM35WPvZmjebEJv7KbH5DrfdN69pWaZjkYKyMpU3072I8ZPzDLgyr8KFE/zr25IpDM95XdbOwOWFizSUg9+Fo1lUDWE5fjq/zexIKgndcp3kouqoFToJALeDECKI9kTXloLLBAQ3YTvrEONrmNchO/N5143oj+e3CHDdxHdj9dVYncn1b6+mnZp2jNZUzn+8hIlJkqAsadEri5RrHFn6HpMl60IFMn4V07GP6wPkrm8aG8gxT
x-ms-exchange-antispam-messagedata: FVo1gBb6xalGYHJuaWugLWHEiG5DEw3zp0ZYMuDp/FTmEmbMLf1q6kMBQkIrkhbqvcBqk1nwvtc/hTlGsrj6Drd/kWuEzrgphCVGOImsT9Ue6Fh9K8uSEPc+piZM4m551VB7IUAcMSBLDfA4hpf12w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcebcfa-0248-4f3d-421c-08d7e293f548
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 05:55:39.7948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbaL3NdOjmnzCZwU6IlvpXL20tK7yRB28hCwIkuKCLWYH97a4Keaz6LFUhouZT2r+ZfOkGo/56rI4sLbTAWfvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4027
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > > Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable=
 'ret'
> > >
> > > Hi Rix:
> > >
> > > This patch is based on linux-next. There is an preceding patch
> > > (3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_conf=
igure",
> > > Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
> > > This patch is to fix the lkp warning brought by the previous one.
> >
> > Yilun
> >
> > Is it possible that commit id may be different for master then?
>=20
> It is possible if the previous patch need a little change when merging
> to master.
>=20
> I'm not sure how to handle this then. But the previous patch is simple
> and is unlikely to change.

Maybe you can resend it once previous patch gets merged.

Hao

