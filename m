Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA9219BC2
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGIJK7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 05:10:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:55765 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGIJK5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 Jul 2020 05:10:57 -0400
IronPort-SDR: rAJFDEqfaRvQbO4z1o8ghJcHdU07BDGg1f2OgbZaOIxoKIlJOqwBAEXhgX9GuZx+oXS2i+HxEj
 JF0iXTVIY/qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="128031583"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128031583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 02:10:55 -0700
IronPort-SDR: +YeLPHZJTmf1BR25adBS9jBNbtSVuDHJhHnOtDCkhZUIOZkCVnSoSwHOuucDlDijaGAoALMG9O
 CtY2wibdekkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="284085509"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2020 02:10:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 9 Jul 2020 02:10:54 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 9 Jul 2020 02:10:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jul 2020 02:10:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO7LX324RQAIYQvYgmYu7FS8K9/BULt6j1S3vL2/KreYoUotK+hoQodxs5IVAPlDUxrhtv+sJyVL/DUqqzaVZsQOIfiOX8aBi77i4LzOqjUzRHpbjKrxsWNhpd9D6CPnUnIE6RwjeAKgMBRn+J92FmhVJAIrjFTZ3/eA90yN4TdeXf0G/Yigc31oM738O7QATJ3i70DHGwPQ+IPS/w2KECjm9bQJSfYjoIk3B1GmZUa9TDL/dxxO7/TRvythnlx9u6gMBVqWTG4EjiXZkHP/ojoyRpV1QCzkgTBoQxRTagJzT00wM5Yf9bchTzHk5RIUudQ0wCU9dfr4ivtREqXFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQHGn+UmsUbQcOVBpWh5/F5Z4W3U3HXuPaNngoNq3hE=;
 b=XRMi1ywHp4qmMYBF6sPsIPblwXxBlQ+ek6Sim38IykEf96/+HEQ4r7DzZaAaQemACIimmRb/+zaxgy7rUd2bAlzybsWmPSEMPgtxyHFhZvVyYllm7Aun7+E1ChlT1MKjYI5I4Vfrw4Vc79ZSJgwFfjZH5aTx4XT/aeAKTHenJVwLU2VWot1KJkIP0nK2ktitE6JvskhtCyNEWB7BhOo9jq2i1NzNLMHOijpawvusjeZzwVz06rNTFc2fQpNkO8FF5DCmRMeN1GxUSLjzYSLDIxOk7IsowtEhQ0j4BgeKDCFTeqmwuogo/qMsC24n0ibpWHOSEiVGLj8x2ao0HRDk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQHGn+UmsUbQcOVBpWh5/F5Z4W3U3HXuPaNngoNq3hE=;
 b=KguSYg6msXYdis6lnTjbXBuvZBmxZMVWKWw6zFM5AsCzH/LzRvZPvjgRd4QaB5c+J5arQOzf2QRvBC7Kl5n4NH9pa78d7BX+qs5fnA9VwceuL2ZLPSL7D8gksuzwqovt+lVChqf4baHlxKdntVvh2dva8/Uu+wwULBiPLmX4Lh8=
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB4219.namprd11.prod.outlook.com (2603:10b6:5:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 9 Jul
 2020 09:10:49 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::c1c1:6930:f17d:a80a%4]) with mapi id 15.20.3153.031; Thu, 9 Jul 2020
 09:10:49 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: RE: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Thread-Topic: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Thread-Index: AQHWVcomDnRuf5Ios0uozSMTJLBb7aj+8y7g
Date:   Thu, 9 Jul 2020 09:10:49 +0000
Message-ID: <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
In-Reply-To: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
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
x-ms-office365-filtering-correlation-id: 0c9cc859-b6b8-4bf2-6180-08d823e7f8db
x-ms-traffictypediagnostic: DM6PR11MB4219:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB42197F04F6F701C2EE6D69B385640@DM6PR11MB4219.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 04599F3534
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbcBNomy9D99VgdQuDyKBu/fFPJq5pzPsWZUDWRu23OUBhD3Qhw0j7v8YLU5nzchYrqMZ33/7RXk1xvqVk8GarSzLNEMFfmkE8RWRZI5jGkV5xyK94hR75bHEtH3mpMZm+DUYmpXvW+e4/t/uLvtR2EiC9w6K8EA1miHunbJh5Nm29OFj4AOEokzjf3WktuEmYngD8hUOq9Yfa7tjC/um6b5RN4s+LRw6gYYXiJKELtsLb61rAAyMgf3oTyPUQ5VmSrBVeHAxNZLsZMfWGkA2usWjNLMXW/bYRblYaNxqFHXPztEyn1zIDz4xf1u+Hud9czPvxAUg2tbWSUOmAYMkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(6506007)(71200400001)(4744005)(33656002)(8676002)(52536014)(478600001)(66946007)(66556008)(64756008)(26005)(7696005)(66446008)(66476007)(76116006)(55016002)(110136005)(54906003)(4326008)(86362001)(186003)(2906002)(8936002)(316002)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9VJf6d2KtNHdJSIqpCb+BsswEVccOrZmHOzh4u5+ULxSOCTBXsX68J3Olm/4NORDSOkgsT+R2BTOp1/V23Ur0l7YSLgsA8nqDknX1cDuKWjlAO/Xv8+Bs3oUCEo+39f4CZzlmOxR3aCOvcao7Iltrd0AXg8nmqoI0os9AL9bCoCzB6aGbv/LrGs+eQ8/PwAHcxQyUHIJqi31dc6eSGSgT6cpawNfNpzSHEQpWiNDaqVbi0CrODrMv7VVJ4dJr6NIFr7xYnzcEI81yH9//kySr1cqXc6uafAae5fIM+LAWhRheUIvsnwZ0aAvYIwPKORZi1W0itcJrwzUQzm0UNyJZ320s7lTOnrLx74VltVldPz8843L0N1X6+yg50R2PcLAcUzEA4T2LJf9yWKvhum9edS9+shh/Gl2vXz9aeR9xzZZqFncfPhfE9+SbUtMVsw1SgmTisbzAneNzGxGO98HF7zbztLNmiC5+DW3aBEfNNuO3SAtHZv1N6woQwSu3eB2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9cc859-b6b8-4bf2-6180-08d823e7f8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 09:10:49.1380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8Kal3cURwv2MrRbAsIY/9Xlnnj3HFR9bZnMKSCkARUQVltkiYa7VpTiXmThwYFh5KP3/sDDvmNrhzaUX9fn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4219
X-OriginatorOrg: intel.com
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
>=20
> Add PCIe Device ID for Intel FPGA PAC N3000.
>=20
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 73b5153..824aecf 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
>  #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
>  #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
> +#define PCIE_DEVICE_ID_PF_PAC_N3000	0x0B30

Should we drop _PF_ here? and also do you want _INTEL_ here?

Thanks
Hao
