Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237DB2B73F1
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 02:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKRByl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 20:54:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:27367 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgKRByl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 20:54:41 -0500
IronPort-SDR: aPKRTNkzpdCjPXOrhAbVlgG3cvMN6VawQVGUHectrcUNrRhGYgBdOtMa70s/zkFpW5kKRq8nwL
 R4Su1inFZ+Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150896161"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150896161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 17:54:39 -0800
IronPort-SDR: PDykufNZvLUZkR4dbJh0qRLWVqC0Bc9MqKtsqidqocsa68XJIMtlpOVCUiNBshGayiHYu7iSUf
 s5muIJf8ECag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="400950271"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 17 Nov 2020 17:54:39 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 17:54:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 17:54:38 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.57) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 17:54:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP9N/oM8YCM3bg0z09AR71nRtILxl++4WUo2POOcBHrpzbbuDXDCnsT9xaIpXVmzk3+MrcDRSrhMCr5M7DtnJV891ogNrJ1YfsQYXWvLk65M9zuRPvaW+LNhMyj2CEnENrfGcwWz9U+YuK2QUeYPRcbdIcWM0keFtW+1tYKmD5nkTJFbQfzwHj4EX7bZ91+soqX6gIT9Gj2e/J1LGrubL2UxRIm99dcxBzo95WZUnSjJHKyL/aLpOscwjFQlHPFxpt/hhwF0pZi4mGkzBgBeZOcOktFQwgWy7aq4M8rO8i4I6732iPXSpDRM4fe5H7BeJRgOzniDEyvpdd4x1jMuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvQ9OdilSEnhhNUC/nk5W/5PJibzO4i2Y4sd4Am+oOU=;
 b=DMSnl4+hhZ8YWu0HbCFgBnUcr6EaqROpGx8CGK4b8AV3wMg6I0MLNiOY0Zc4JPo2mwJzahrXBBlN2WAMI4dcoTPHwoqnu1yX3grcbehnsZEReOFPij5EVyaB66qKjU0SWAZTehM1YsYoyYwr9tV/dWYewZB2aFFaEliyBX2+hbgsNwGixU+u8xiPVkH9j7z9KEtMntvvngWX17x/lquiu7pD6zvzT1SmtuuYSOQAOqqWSCRESRkL394pd/7fwtc51mKVUrHNEgVMh5AK3dVDFFYowcRNBfHX3OA5IyqM7ynXpcBpzPkkmIbRLoTw65rkG2T3+HyMnLRhDLFPSicDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvQ9OdilSEnhhNUC/nk5W/5PJibzO4i2Y4sd4Am+oOU=;
 b=uebitjGpgW4mb1s4ii2Cy0xAD9DWHoxQcSbsU+9Rh7mNG4QgIW5fq71MecAYrlGXnXbNv7tAzvugQMOrBeUAMhE8bFrAwag49IN8VrDagcLBbyO/bprBLbWUZaeM/9CaWIUurslcAHkh3iq42KzG7H2rThO2I1V4rnvRlRVjNOI=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2570.namprd11.prod.outlook.com (2603:10b6:5:ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 18 Nov
 2020 01:54:31 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::69e0:a898:de56:337c%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 01:54:31 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Thread-Topic: [PATCH 2/2] fpga: dfl: look for vendor specific capability
Thread-Index: AQHWvIBxykoMIcZrHUW2ir3zzcjKk6nL978wgADKdoCAAFpl0A==
Date:   Wed, 18 Nov 2020 01:54:31 +0000
Message-ID: <DM6PR11MB3819B7E06DB9A4BC7FBDABD285E10@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
 <DM6PR11MB381979D8AEDC1F4EA8B4C2BC85E20@DM6PR11MB3819.namprd11.prod.outlook.com>
 <alpine.DEB.2.22.394.2011171144310.296481@rhweight-WRK1>
In-Reply-To: <alpine.DEB.2.22.394.2011171144310.296481@rhweight-WRK1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f033495-38f8-4a7d-9881-08d88b64e455
x-ms-traffictypediagnostic: DM6PR11MB2570:
x-microsoft-antispam-prvs: <DM6PR11MB2570B6AF62523A29E9E9B08385E10@DM6PR11MB2570.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8n0bsovMiAaNgkALZJGjI3vpGzaaGnAx/chaZY43YXBp2bulAhMavK8N40pHu64nHC3GG9FhTKPR2N1fzRNPtVYSJXbm+rqkk+Q3Npkh2b5cDhgbLzXugayM6r/cV6xYEJYrr1U/jh46Oz4UuMDOEhz8MmQ0K0qELTJM7MjibT0GyXgVo1mlQF1mBgxtyzZS+I7JGxwlmF4fCDLSWJfx8kTPo/bV2J09KK2SO2GuVM+7iAWhWFatgEcwgWR+3jzLvUnd2lAfITuU5mmyugr6Sch5nApzQfsyLPzKM5Y6To0lU/MiB4dRA+jOzcmmFGn5+R3AYv0uR+RKhCUo5FrbHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(71200400001)(54906003)(26005)(7696005)(8676002)(8936002)(33656002)(186003)(5660300002)(64756008)(9686003)(55016002)(498600001)(6506007)(52536014)(66946007)(66476007)(4326008)(6916009)(86362001)(66556008)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3Cm8wH4FaFye5fSwmaB14Y6+xQIRUv4SOqRa4xO6kZ8D1OwsQTeBqpyoAT9ub23Shofi+pWHJVrSTKt20M9Y2FLgCWySe2UdSVLrQyl0+a9PNYMOyTaV61/jE4Y01JS/fzYe02mH9pcTSUT/QqSZvpsATeQBphFclKJTskQZPLgkiO3UtcAWyJxuyv2XpybIDjr0UpCHCjVc3uuvxcT2JYvErakal6EFvDLUvC7cKjEse3NVFlEceDGLT1fHkrDPxjRabNnG9Ard7mzry3EnYXoUGUwal0hhWjL8K9VASLIHapjFnj3il356PGqROyW4caBCT8hh6jd+7Zazkc67RuSe6rxHAlz1oNioAGe3jFhHZbKPXcTLARaExe8KRyJDbMlqNr+I86EkYiAc8Z+ecKPeE1ZPyfiN0yIMiF3U/0q7iM791CWQ9mJANfu/AxE5m5ew7d3n8clahIxQhzDT71IbieC4HeivfEo6HBI6xt4V4zxh259cmXI6Y0Yd6oJ4bDY05vu2zog0WQYffo/MvYStxgCu5U0ishrTfEBVqTnw8WUqqXcZ9PdAM2tp6aMizdVMzKrDWL0ZB2VOR4lyCPVQmCWwKSNT4leQbvtd0W2gBdX/bCX4hB9agFGlz7KKUBC4EIaXw9sS6MXgeVqb9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f033495-38f8-4a7d-9881-08d88b64e455
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 01:54:31.5411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwhJAvjBWE83fp54d6E9d2hLBG+PQ9FMKTClS5gv1r9dC2U4SRTCL03zpZgfpe1HNAn9Wj34Y5rIvtwJ8RJh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2570
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> On Tue, 17 Nov 2020, Wu, Hao wrote:

[...]

> >>  Open discussion
> >>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> >> index b1b157b41942..5418e8bf2496 100644
> >> --- a/drivers/fpga/dfl-pci.c
> >> +++ b/drivers/fpga/dfl-pci.c
> >> @@ -27,6 +27,13 @@
> >>  #define DRV_VERSION	"0.8"
> >>  #define DRV_NAME	"dfl-pci"
> >>
> >> +#define PCI_VNDR_ID_DFLS 0x43
> >
> > What about PCI_VSEC_ID_INTEL_DFLS?
> >
> > Is it possible a different ID chosen by different vendor?
>=20
> I think another vendor could choose their own ID.

If another vendor could choose their own ID, so should we
check vendor id as well?

[...]

> >> +	for (i =3D 0; i < dfl_cnt; i++) {
> >> +		dfl_res_off =3D voff + PCI_VNDR_DFLS_RES_OFFSET +
> >> +				      (i * sizeof(dfl_res));
> >> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
> >> +
> >> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
> >> +
> >> +		bar =3D dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
> >> +
> >> +		if (bar >=3D PCI_STD_NUM_BARS) {
> >> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
> >> +				__func__, bar);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		len =3D pci_resource_len(pcidev, bar);
> >> +
> >
> > Remove this blank line.
> OK, v2.
>=20
> >
> >> +		if (len =3D=3D 0) {
> >> +			dev_err(&pcidev->dev, "%s unmapped bar
> >> number %d\n",
> >
> > Why "unmapped bar"?
>=20
> How about, "zero length bar"?

I think this checking can be covered by below one, right?
if (offset >=3D len)
...

>=20
> >
> >> +				__func__, bar);
> >> +			return -EINVAL;
> >> +		}
> >> +
> >> +		offset =3D dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;
> >> +
> >
> > Remove this blank line.
>=20
> OK, v2.
>=20
> >
> >> +		if (offset >=3D len) {
> >> +			dev_err(&pcidev->dev, "%s bad offset %u >=3D %llu\n",
> >> +				__func__, offset, len);
> >> +			return -EINVAL;
> >> +		}
> >> +

[....]

> >> +
> >> +		start =3D pci_resource_start(pcidev, bar) + offset;
> >> +		len -=3D offset;
> >> +
> >> +		if (!PAGE_ALIGNED(start)) {
> >
> > Is this a hard requirement? Or offset should be page aligned per VSEC
> definition?
> > Or this is just the requirement from driver point of view. Actually we =
don't
> like
> > to add rules only in driver, so it's better we have this requirement in=
 VSEC
> definition
> > with proper documentation.
>=20
> The DFL parsing code ioremaps the memory bounded by start/len.  I thought
> this would require the start to be page aligned.

If consider mmap the region to userspace, it requires page aligned, but do =
we
need to apply this rule for everyone?

Thanks
Hao

