Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BA3B266C
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 06:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXEsK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 00:48:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:62483 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhFXEsJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 00:48:09 -0400
IronPort-SDR: wRUGTyHbq727K0mV9z+2hFUsdZHFYOv9kRZS4MiSagESykDiYf7vXzU6hPKy9qnemx1wqxn+81
 6J10TRY+hWSA==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="207332727"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="207332727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 21:45:50 -0700
IronPort-SDR: iUCW69lMqmZAOi1zPlIC7+tmzJafz30CBu++hPNjoMxUjKwrGJfYICMbxDfeJXBT5xQOCXUDrS
 q3UDU0n37wfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="454905574"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2021 21:45:50 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 21:45:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 21:45:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 21:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdzJdq6VdQEzhBlzgeXfwNtVA2g3J6z6AigzHIOfvSx3c5rAmzfBpz2NU8yUse9zzI0bjsVMhxezaqTof1tzetzl817dPnlgDhcwKFz9MGS7oqUaslY6nwv7fzpZNozv5JaDs9WqiAlk7RSloHQCgJo7184Mi3NND8QWs4nmngXzWCPlLWu0hBkpTvZSihPtcGg2ZIwvXaYQwOKurgQgMgxY7Uqf/8A9wsV4ZJclB85BtN2ySCiVbvDYjYtaWjsj/9BqM/OIkOjpkygXFFFhjqK55XwtvVNnz05zB/BnfYelu8oJT9SINNHWWAgU8ivvOk8GnvhsaiNEo7oDdYU1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvk9hhAXQ5a+c6igZs5RyY2S4nUn9vAOtnHSJiyHwPE=;
 b=V37DJrXs78eZKP5qxBYcuVBUOP0sRJnypEbUzikviwbQf0daiMzGb/BTBcsIrnZNhWWJdm/m4PkhrtdMKA7Aaij3GqsGWaULgQcLMB8RXPVYz8yVMcotAKEjkkDy8Yxd0ScCR9UGGaGILnSllJDeIUoohjMaNfV7g2i9Z56cZoizLl6yMQ0Jj0eI1V2j1ZU8rBOAaD7FIgChYpePii9e6gKb2+AXk+IqB+v9/WTXV9dNOsb+Lq82OxVYaerngxAcQynui+Cq8vka7a5f53+nCvJKNqS6yTVuJ/9f08xBnWG36/idlkPZuI/FdTwyE9GelLgl9DZSTtt7f8vab9+wHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvk9hhAXQ5a+c6igZs5RyY2S4nUn9vAOtnHSJiyHwPE=;
 b=gHeJhLf4dlXuHEDeX5V2xR+p6eUSwTwep2Wgps1QLnjATvPn/d7eMjG3jHzcSXqWHzAvzfQ4AEUTjt7vf/v88//+rYhMo5vSJOJtYquFpuPokzR0544FiMMzdSfgTDmMFsSacErlhcCAoiO6ATFLXbz8XgEwRYCTSHYhyQIzhrI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2889.namprd11.prod.outlook.com (2603:10b6:5:72::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Thu, 24 Jun
 2021 04:45:43 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::3dc3:868b:cec3:513b%6]) with mapi id 15.20.4264.019; Thu, 24 Jun 2021
 04:45:43 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>
CC:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?iso-8859-1?Q?Martin_Hundeb=F8ll?= <mhu@geanix.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Debarati Biswas <debaratix.biswas@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Thread-Topic: [PATCH 2/4] fpga: dfl: Move DFH header register macros to
  linux/dfl.h
Thread-Index: AQHXaKX26fHcMFRuKUe6sbK+IT+SDqsikQtw
Date:   Thu, 24 Jun 2021 04:45:43 +0000
Message-ID: <DM6PR11MB3819B96AC0E54AF96EDE728485079@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20210621070621.431482-1-mhu@silicom.dk>
 <20210621070621.431482-3-mhu@silicom.dk>
 <DM6PR11MB3819FE54D2C399DDBBC38FBA850A9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20210622052205.GB27046@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819B9B2F357B9B03F7707B685099@DM6PR11MB3819.namprd11.prod.outlook.com>
 <0257dcaf-348a-375d-6ed8-657974208e30@silicom.dk>
 <20210624030120.GA42039@yilunxu-OptiPlex-7050>
In-Reply-To: <20210624030120.GA42039@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d576d09-ef3b-4afe-cebe-08d936caed24
x-ms-traffictypediagnostic: DM6PR11MB2889:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB28891A07F1A81ED7A666DCB885079@DM6PR11MB2889.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9T+8jW7l2TLSFKhsPjHpFRqhqJjhYQON/nge1XjKfqejraZM5xmtPTid5geMnOkTmEnk7JoIm/6z668m3pWGcohK7DeeNpjUmGwG19n+RRFEIq8T+ypi6K0Aj/IQ5+UVEBjIdRQVntrnNnO2ZBMbbqFPAREfGMLxaq/L+mn9nq2ttnpqNsVS/3oHPAKIkJxcD98m6Ff/c7uQAU4TuaNQg+bEfafYvALKlEqywGnNKKEWFeYTOgD9uLah+ETgENjnpzTvf1C2x9RsHjftdUUwXyqv+YQ3KQhDr4JyiOuOycP2LZCrwnWgUXl09TIz8nXfzSc8wnryH+ODNHbysMGn2PCDh4cGIHKIWWwum+LKFXe3lgLxz+gs9RlvLBuKUBdiL19pJqMFSLWT/YeEOxL3J5o+d2e6QzUX8JB02hPaVGK6qFT4nGHi3zof3sgmyXwaPnEwKV31Sbxy7Z18bJEabZ8rDFZtvUQ1efsMDVdPa8CGc16Vq5Qy7TQ/8TEsZapIsJJc9nrxyxIaLFMZoe/3v4SaHOTAo9hpoTxUfPPlEMWId6QTShfWJNLsE+bvprNRoEjdNF0ZX0PgpMr2jC/cWoFi1N7PuRM1nEIzZVtkQ5DJoyJIrBkv3KWEXQirdOBfyrWv7aHScwwdXhesuTNbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(39860400002)(366004)(71200400001)(4326008)(5660300002)(478600001)(52536014)(86362001)(186003)(38100700002)(8936002)(6506007)(9686003)(55016002)(7696005)(122000001)(8676002)(107886003)(54906003)(26005)(66476007)(66556008)(66446008)(7416002)(64756008)(110136005)(66574015)(2906002)(76116006)(66946007)(316002)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qQbGLRI+FtlED4zrnnjYwWOdwPf24pBVkDvWCZshTDnIDkdlTLsY1fKG4a?=
 =?iso-8859-1?Q?9b1GVreiktRheAXZR5Zna/7WL82CzJawX9nD0CUHR0FdzhxNcUgLo6ee7l?=
 =?iso-8859-1?Q?oC6kYdFhk9gW3iXracq0YrxcB2EC67GEyDIxiAFRA1o3PxxZYIr9RFO3MS?=
 =?iso-8859-1?Q?kgcYkGJ/mPkXsSP9DaV69HnyLjvH7LkK0I4qdqQKZV1mp62AUXUAyjWC6+?=
 =?iso-8859-1?Q?KoX55PzOWuOIcqVP/yCZtwX11zyeCEbrYR2Ei0zFSDlsMFwpI5kvCkBgeZ?=
 =?iso-8859-1?Q?hSz0HVzfouo53+8s4RmD7XS7qQ34wd1WQGz6xKQB6ctt+y9ogWFy8JPjsE?=
 =?iso-8859-1?Q?oWShuLDEzjj/TIWSa2K4/v+ExoENMl95HBrTePi5vCebgpdX//JqeGtrZd?=
 =?iso-8859-1?Q?xT20pXDnsI2LC11f81uV3mBbzt+fTEU74vfzho2yNifjPn9pFAITsEH7rs?=
 =?iso-8859-1?Q?BzP4z/IT78Jx06kPXQeVdZ4ysx/zF1bkcugs7smVZU7Jtfs8XvDxGVfwm+?=
 =?iso-8859-1?Q?YhZEZ3dzsQrUvAq18BF9wT0SHVDukkHcIfTGeKJBs2l8Mv2jjNikTbDErq?=
 =?iso-8859-1?Q?1cLobDeMX1gRT5pkXu+nJzgkHvlCkjCbFgBQBf+BjEg1KW8Qq76anDY94k?=
 =?iso-8859-1?Q?JO8VYH7DAUw8s6YrpQxPX+tdlEe8h/XQK8z6FuMAwZ/HT/QUfulatGr6fH?=
 =?iso-8859-1?Q?Gzh0rzCsz6wpqoZM8bP6UqQki9xekRv5XdVbFRCgGwxwrZ044rBFB4qWtK?=
 =?iso-8859-1?Q?31EylzGkR7p/0YBNI0JwTTY/Wn5spIn+MMtFFrkA3xhWYiXtlIrO7Bd8vG?=
 =?iso-8859-1?Q?QGEOGza70pgVc2aqkgDcd89cyvQ/PmW07C1mVR1BpusidDXW3e2ZlOiiFW?=
 =?iso-8859-1?Q?H6aa47f+s0+UEIJZQwRPKlfhgkFTQWDkqXVXTdTNsCSclL66kHZwgOQ5tb?=
 =?iso-8859-1?Q?C2/0V4elhM0SHlQXwtTMU9TbVu6ua61kBUyWjbjP0fztkSFAJkUZk8grH1?=
 =?iso-8859-1?Q?FTwaqWlAuVahiCYO05pPdBwJ/akNwlQ4HJypIIbNKF8HhznEJdBTZDbEqg?=
 =?iso-8859-1?Q?BaPCNuwnE8L08+unozBLsuIkhdPSt8zGvdzOxmjE55ODCh7BeQfYT8VFYY?=
 =?iso-8859-1?Q?tcLcYOaMxcpretVwqKkpQ4nN47VSWlPt48DFvt4F8nng6c0OZm5SnaF49D?=
 =?iso-8859-1?Q?32AcSIRveGhgXYQEO7crnPHxuXETXm8c7xPn4uL8bpH327GZDvCruHdE4N?=
 =?iso-8859-1?Q?/raCdQB6WpyFX7h+izvUPliDiwl1L4Q7RGstRlV+asuqCDuhQkOPNN/ITF?=
 =?iso-8859-1?Q?Ce539TsJK6FVvCp3Kbkia9uc2hYjQmSjW8fuTx80DeLpJv82vY1q+NEyxK?=
 =?iso-8859-1?Q?D680iPUYqJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d576d09-ef3b-4afe-cebe-08d936caed24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 04:45:43.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 227P/dDrQRLlppF9atBynnnzngkTNmX1E+WCuXomEoadcgYL39lNqgMF7e+vHgzqMXMSD97GNdOjoM8ccS23YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2889
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Wed, Jun 23, 2021 at 01:56:59PM +0200, Martin Hundeb=F8ll wrote:
> >
> >
> > On 22/06/2021 09.39, Wu, Hao wrote:
> > > > On Mon, Jun 21, 2021 at 06:19:15PM +0800, Wu, Hao wrote:
> > > > > > Subject: [PATCH 2/4] fpga: dfl: Move DFH header register macros=
 to
> > > > linux/dfl.h
> > > > > >
> > > > > > From: Debarati Biswas <debaratix.biswas@intel.com>
> > > > > >
> > > > > > Device Feature List (DFL) drivers may be defined in subdirector=
ies other
> > > > > > than drivers/fpga, and each DFL driver should have access to th=
e Device
> > > > > > Feature Header (DFH) register, which contains revision and type
> > > > > > information. This change moves the macros specific to the DFH r=
egister
> > > > > > from drivers/fpga/dfl.h to include/linux/dfl.h.
> > > > >
> > > > > Looks like it requires to access the revision info in the next pa=
tch,
> because
> > > > > current dfl_device doesn't expose related information.
> > > > >
> > > > > @Yilun, do you have any concern to expose those info via dfl_devi=
ce?
> > > >
> > > > Exposing these header register definitions are good to me. These re=
gisters
> > > > are in DFL device's MMIO region, so it is good to share these info =
with
> > > > all DFL drivers.
> > >
> > > I mean expose revision via dfl_device, as dfl core already reads the =
DFL
> > > header, it sounds duplicate read in each dfl device driver. And if we
> > > consider this as a common need from dfl device driver, then the code
> > > can be moved to a common place as well.
> > >
> > > I hope from dfl device driver side, it doesn't need to know details o=
f
> > > how DFH register is defined, only simple way from dfl device data
> > > structure or some simple helper function, then dfl device driver coul=
d
> > > know all common information from DFH.
> > >
> > > How do you think?
>=20
> It's good idea.
>=20
> >
> > struct dfl_device {} already has "u16 type" and "u16 feature_id", so it=
 would
> make sense to add "u8 feature_rev" as well?
>=20
> I think we may name it "u8 revision".

Sounds good.

Then we don't have to expose detailed registers information to such header =
file.
dfl_device data structure + helper function should be enough. : )

Thanks
Hao

>=20
> Thanks,
> Yilun
>=20
> >
> > // Martin
