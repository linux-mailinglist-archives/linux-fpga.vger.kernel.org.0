Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EAF1AD4B2
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Apr 2020 05:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgDQDFU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 23:05:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:42625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgDQDFT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 23:05:19 -0400
IronPort-SDR: rTBmR8vDhK3HXJGHnUTs7JEKfNFvgEBdlQUQxn0Gxy+i5ZtaoVlNcEuOG+T9ML1IcRx81NTSeI
 KUcmuQxKYG6w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 20:05:19 -0700
IronPort-SDR: yx1B5KmqV9xbKw5Y+qe1SOnUCmpSn0wKegVIXGQOXmAo6nq4ZsfpUK8i29WsiZ36gNQ5rrGvmM
 5gk/QCHHgARw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="299490520"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2020 20:05:19 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 20:05:19 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 20:05:19 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Apr 2020 20:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU1UVxVoSYH2O8NWqMigDKeOhFtNcOccPnyxWTpTBImf9v+a6Yh+ryI9Qq/pNlMYGdidZL/B/32Y73QU0yQev3hhr+XQseP92Ts2wo8F6HaSAKpBPzkx/XoMd4rJ2LgP6xkyZWYwlsPluHULt8Na1c6UJDc/01a6WTn3fIFNqn9aSQluZB3eb9RkNWOShsNoNQV9m4N/1/gw7u0iQ6Fwbxp5nxagtZEGxPAG/bGnbgek2ZoTjLH4Jz5kyjRDNA4uqEDTBivdoDOwN21ff2dglYplIALrUqM8ynqRc+pirZ3WRMzQPTshS0AV34FlL/NRjHXuj7pfGp673EdNFtfjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVgUMGnjOyhufcziJ/kUyrrl5LHowYpd7U+NPvgBmiQ=;
 b=XJzGoE4eHt5UBS4eMpj5bAIUsf4PnNnI2xP7XhwSxZ/RtsNZP5ATap6TjWEWuqzNP4jb+om9FwU10PdNbc50lFpuUgY30jiQGFP/Beot2vkqWzu9fE5GRaCWZ8GZevU1IPN2oepcj3+GaxHFX46svfgxqcBmN43zB3bpfbn2B2RB+EcDfYim+vmGRsRaBLi8lEi9wryi7qAAnqcKu3ye01ej8VUuFiCnk8QJWrRkqIvnOIEgLPLN3Tnu1uIz1kFLfiBU7nabF9Dn/qDmuLQ2IyWHxmGNiGZJYqUy6Ews3c00m3958M5F7yKEgmfDe/qqOqydWKlVr/t8rFuDPEFwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVgUMGnjOyhufcziJ/kUyrrl5LHowYpd7U+NPvgBmiQ=;
 b=ZkgRuHHLjMV9/ttqEoP10DBCDHNmjODDG32cMoNgUmsh2CAGr9vJ4Y/4wk5Xo19yaPuN72iXORbjtWdS/OnlnomEy8wPuFzGGj5Ky/jK5FKot/Lbtj+mjmf8moq8NesWUI0WPRk+nLtjRs+7nM03JOxLjJ1uu6p65sjV2b2YaVI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3882.namprd11.prod.outlook.com (2603:10b6:5:4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Fri, 17 Apr 2020 03:05:17 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Fri, 17 Apr 2020
 03:05:17 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhu@redhat.com" <bhu@redhat.com>
Subject: RE: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Thread-Topic: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Thread-Index: AQHWE5193+0/nQdMD0KUurSvMI7dQ6h7YzcggACVlYCAAJaugIAAEAvg
Date:   Fri, 17 Apr 2020 03:05:16 +0000
Message-ID: <DM6PR11MB381919B83DB49F937E3EDEEA85D90@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9b1d85e0-4f44-179b-c847-af858fcc212a@redhat.com>
 <20200417015605.GA30618@yilunxu-OptiPlex-7050>
In-Reply-To: <20200417015605.GA30618@yilunxu-OptiPlex-7050>
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
x-ms-office365-filtering-correlation-id: 0814a210-1728-4d59-76ea-08d7e27c2807
x-ms-traffictypediagnostic: DM6PR11MB3882:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB388296141BC49F7C6B46269B85D90@DM6PR11MB3882.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(366004)(26005)(110136005)(71200400001)(7696005)(5660300002)(66446008)(64756008)(33656002)(316002)(54906003)(76116006)(66946007)(52536014)(66556008)(53546011)(8936002)(6506007)(66476007)(81156014)(8676002)(86362001)(4326008)(478600001)(186003)(2906002)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8dCoz2JXlo/7TaluY8OIlW9ZzYJ6yW9tF+xpUYX8LRWRD/a/DFuk/sF7kJIOBOiKFiasnd7OBUKe4ulWv/eRx8Gpn/mG7fhr3VGunYz7XFekMWsqDDZOsp/VnUiGA6d32tP9gV71reEf6Pqkyj2C6vjxKqI/97L35dssnqSqxGQ+TDkyBdfRQbPylEcpkZT+qhOGM4zIPTT6zFQGNDDD5B/lMT9CPDvbOZIcMiAu3j+1Ej/RMXgt9tAn18OBrUweRnMX0FPAaY8PPD+0Nyay0UJ+NiIMO0zariIfBKLKPycqWa49OkwYjkBiOlFi0mPWgAz30yoOvWiOCmZ61H/+ebhH1HK8zK9xXIi4O3qVZMA1hHynQmArFL6GPK6cITD7m/2BBSt228H3H54OclyzXbnGmtRPmYH5OjN8697YLxnoHgDpn+91q1+p5dQ+RwoR
x-ms-exchange-antispam-messagedata: ybB847/HQtrxmVcx0BurTreeMB46XTa2ivxLNgFHhX8/KSscxLh6U8zNh/glgfrZSB6kpzprp9FsfH8JN4BCyDrkrfKcJnPfXhP4QR0OwoL0sYvgHYFDjmRkc2e2hGB7N8JNJ2lYdJoN90q0wvqWTw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0814a210-1728-4d59-76ea-08d7e27c2807
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 03:05:17.0145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjuH4gTNm6+K6neXytliQTtQquZQ0hu3ZkY8Gl07rhvQIWQb+kMkxlGvnC9/2ojEttmkUvxt4VGQBfZslPP5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3882
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Xu, Yilun <yilun.xu@intel.com>
> Sent: Friday, April 17, 2020 9:56 AM
> To: Tom Rix <trix@redhat.com>
> Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> fpga@vger.kernel.org; linux-kernel@vger.kernel.org; bhu@redhat.com
> Subject: Re: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 're=
t'
>=20
> Hi Rix:
>=20
> This patch is based on linux-next. There is an preceding patch
> (3c2760b78f90 "fpga: dfl: pci: fix return value of cci_pci_sriov_configur=
e",
> Also see Fixes:) in linux-next but not merged in 5.7-rc1 yet.
> This patch is to fix the lkp warning brought by the previous one.

Yilun

Is it possible that commit id may be different for master then?=20

Thanks
Hao

>=20
> Thanks.
>=20
> On Thu, Apr 16, 2020 at 09:56:47AM -0700, Tom Rix wrote:
> > Please check the scope.
> >
> > On linus/master, the result of this change looks like
> >
> > static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
> > {
> > =A0=A0=A0 struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
> > =A0=A0=A0 struct dfl_fpga_cdev *cdev =3D drvdata->cdev;
> >
> > =A0=A0=A0 if (!num_vfs) {
> > =A0=A0=A0 =A0=A0=A0 /*
> > =A0=A0=A0 =A0=A0=A0 =A0* disable SRIOV and then put released ports back=
 to default
> > =A0=A0=A0 =A0=A0=A0 =A0* PF access mode.
> > =A0=A0=A0 =A0=A0=A0 =A0*/
> > =A0=A0=A0 =A0=A0=A0 pci_disable_sriov(pcidev);
> >
> > =A0=A0=A0 =A0=A0=A0 dfl_fpga_cdev_config_ports_pf(cdev);
> >
> > =A0=A0=A0 } else {
> > =A0=A0=A0 =A0=A0=A0 int ret; <--- defined here
> >
> > =A0=A0=A0 =A0=A0=A0 /*
> > =A0=A0=A0 =A0=A0=A0 =A0* before enable SRIOV, put released ports into V=
F access mode
> > =A0=A0=A0 =A0=A0=A0 =A0* first of all.
> > =A0=A0=A0 =A0=A0=A0 =A0*/
> > =A0=A0=A0 =A0=A0=A0 ret =3D dfl_fpga_cdev_config_ports_vf(cdev, num_vfs=
);
> > =A0=A0=A0 =A0=A0=A0 if (ret)
> > =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return ret;
> >
> > =A0=A0=A0 =A0=A0=A0 ret =3D pci_enable_sriov(pcidev, num_vfs);
> > =A0=A0=A0 =A0=A0=A0 if (ret)
> > =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dfl_fpga_cdev_config_ports_pf(cdev);
> > =A0=A0=A0 }
> >
> > =A0=A0=A0 return ret;=A0 <---- not in scope, not defined here
> > }
> >
> > Tom
