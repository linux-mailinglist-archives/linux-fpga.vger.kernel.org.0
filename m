Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDB1ABAD4
	for <lists+linux-fpga@lfdr.de>; Thu, 16 Apr 2020 10:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440769AbgDPIJ3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Apr 2020 04:09:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:16972 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440675AbgDPIEi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Apr 2020 04:04:38 -0400
IronPort-SDR: DsJ9c7qzkhz0GzDDCAEq2SLI9iZkABT9z0roWxBWHyLvXioOwKxnc9XPOmou0sCBauNMifAfZz
 J94luCWFUzxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 01:04:34 -0700
IronPort-SDR: 7gACtVKVc35tm5+gxR4tEB1gwmU/z2u6DsyX/aqIm4L/2TbRpSoBiMplvM08YQf6LWsREBHAlp
 Y6z+yg+rqUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="245915866"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 01:04:34 -0700
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 01:04:33 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 01:04:32 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Apr 2020 01:04:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIkf2vAsX3WqD90k1HY6TQAZqnsIgV0iMLs482HFNNfSI+Jam/PWhh04Na+rQ6E+j0Cb9X0V7W+s7trRyLyIB89XPr7GOnk+1bnwGyu1LpjR3D0X5JocD5Kg+0op4SzZ3LIyY6L22pl6IlrPcjq87F+uJP8QhwnGl+lX7JkqLC7v7GiU6A0Hyuq04t2jLKMdXTaGMyGqUOc1pu7HvjDZuW2eycT6zxRZHiA39laqY9zvgXP0t2bfwIJuJiOE2USn4On99yb5wmiMuAUx2KtOxDubvv3/teeLC1M9Wi7FGiPuf+CoFdV4jKdwtY+VNnTJuaY+cqzX1U1KAIq203a2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp9yhZK6IsPpd9nobkg05a1vSXNOU2GETu5iLhDnNlY=;
 b=QQXxxKFpPHaHkcJHnWQUKpyWaFDccVJ+Jlk4kBDNYVWZ+ypjbzTNHFghuktLyyDfmceIUQrCRMB92HcAz9Lvih6fv6sPnvpntYmGyJzDtsKKgp3fPb6D5Cp85o7f+i1gO81IzHvpn0spx910fHaHBcLeG1zvKKaBAuis0AjAQgx/rEgLoIJlygq0fC9a72xcUCHKx16RXngiN8yDyqnbFN4k1KQQJbiq+LAX/QjG8iSP2UZ3WQEfbIau6eurIgo9l4KaOBehehUNQsGstCAXEUju4VPZ1Na5SLW13sZ7AJiPjSeGvm1LK0FHTR4uSaIMB1a2miSST5Vnv8IqSAh5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp9yhZK6IsPpd9nobkg05a1vSXNOU2GETu5iLhDnNlY=;
 b=PIyhFm+DixjyqVYh149OIOkxdCflibRchzqHf96JGIugX9myaSlvtOBNAD4AMCR2AJzKW+HpWewZpQ4MaIKcyaMYFuOaGWC8bEI+lbFoGyrWpPO2ybpcu6+9/p16awp8bCfq3rZatzDIuin5NYl4wHOv67YrD6pqZWCZCeQP1DU=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB2809.namprd11.prod.outlook.com (2603:10b6:5:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Thu, 16 Apr
 2020 08:04:30 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::98a:bb06:5551:e5a3%3]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 08:04:30 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "bhu@redhat.com" <bhu@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Thread-Topic: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
Thread-Index: AQHWE5193+0/nQdMD0KUurSvMI7dQ6h7Yzcg
Date:   Thu, 16 Apr 2020 08:04:30 +0000
Message-ID: <DM6PR11MB3819619E9B2C7326218247E385D80@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1587006712-22696-1-git-send-email-yilun.xu@intel.com>
 <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1587006712-22696-2-git-send-email-yilun.xu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hao.wu@intel.com; 
x-originating-ip: [192.102.204.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a3c550a-d946-4eb8-1d63-08d7e1dcca9d
x-ms-traffictypediagnostic: DM6PR11MB2809:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB28093837FC5ECB8D83EADD5885D80@DM6PR11MB2809.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(39860400002)(376002)(346002)(366004)(66476007)(64756008)(66446008)(6506007)(110136005)(478600001)(52536014)(54906003)(86362001)(316002)(55016002)(53546011)(5660300002)(66946007)(186003)(66556008)(71200400001)(76116006)(26005)(4326008)(9686003)(33656002)(7696005)(81156014)(8676002)(2906002)(107886003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ILkW77kw4HPHGxCzdiTy2DtUJvppeRqWAkEAHcIIFcXlHxvpRTIt5OkQlQTT1gydCMUpI+qc50pU63WfLCpnl+yJVgnaqXXvBG8zlIrjikRBDIT5GK/FLcn26kmIHOo23G4+/VEunhq5+GH+rFxW0JEEgtHRMfuNfzi9wav864lHShJppBYkwyCS82bvW/tmj/zDKffOVsJI+4+CBvdeGqtqrPIBuRZfRgZhJU6KGjc3XzxZJ3n6ataYnUETrr1fmcXEJ3IHcp1SodYqt3+VfSV5+ETdtfGE9a8fK2PWi+7uMiZcW5aloV8K/IzL1a1RRFalJ0/aXMeTezq790mTJCzk+ynTXe8qwZO6A4jxRoJ/pvy7WLIj3g9qL/xGh4GikXdIYCslIV8mfQsB2CmPxKOW/AEclBIkhleQVkXKK17YM/i5qQ00mhcMEJK/PG1c
x-ms-exchange-antispam-messagedata: ieCZ2pIb39u8rwqqFoWbvOsR3E+jf8O2oq+q+nDOWLRHPPMTe/BPAYJBkKnR8hHuXrMKkx81GOevAQa1Z8XBjEwiX8PlAcO9USidqaEVPVWwnggt2dqh6yX1NSohMs0196mZJ8qhqwbNME2pd7z+rQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3c550a-d946-4eb8-1d63-08d7e1dcca9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 08:04:30.3014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tN7djQhAaZYXJHjJm+9Nvol/z0h1twJY+Tk/+7T45Lsa89WIRBvnPl17z51LIgnekKQnrmUfreWWTcK+B+KYnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2809
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: linux-fpga-owner@vger.kernel.org <linux-fpga-owner@vger.kernel.org>
> On Behalf Of Xu Yilun
> Sent: Thursday, April 16, 2020 11:12 AM
> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: trix@redhat.com; bhu@redhat.com; Xu, Yilun <yilun.xu@intel.com>
> Subject: [PATCH 1/2] fpga: dfl: pci: reduce the scope of variable 'ret'
>=20
> This is to fix lkp cppcheck warnings:
>=20
>  drivers/fpga/dfl-pci.c:230:6: warning: The scope of the variable 'ret' c=
an be
> reduced. [variableScope]
>     int ret =3D 0;
>         ^
>=20
>  drivers/fpga/dfl-pci.c:230:10: warning: Variable 'ret' is assigned a val=
ue that
> is never used. [unreadVariable]
>     int ret =3D 0;
>             ^
>=20
> Fixes: 3c2760b78f90 ("fpga: dfl: pci: fix return value of
> cci_pci_sriov_configure")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>

Looks good to me.

Acked-by: Wu Hao <hao.wu@intel.com>

> ---
>  drivers/fpga/dfl-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 5387550..a78c409 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -227,7 +227,6 @@ static int cci_pci_sriov_configure(struct pci_dev
> *pcidev, int num_vfs)
>  {
>  	struct cci_drvdata *drvdata =3D pci_get_drvdata(pcidev);
>  	struct dfl_fpga_cdev *cdev =3D drvdata->cdev;
> -	int ret =3D 0;
>=20
>  	if (!num_vfs) {
>  		/*
> @@ -239,6 +238,8 @@ static int cci_pci_sriov_configure(struct pci_dev
> *pcidev, int num_vfs)
>  		dfl_fpga_cdev_config_ports_pf(cdev);
>=20
>  	} else {
> +		int ret;
> +
>  		/*
>  		 * before enable SRIOV, put released ports into VF access
> mode
>  		 * first of all.
> --
> 2.7.4

