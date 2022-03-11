Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903D4D5982
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Mar 2022 05:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbiCKEV6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Mar 2022 23:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiCKEV6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Mar 2022 23:21:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF12C1A1298;
        Thu, 10 Mar 2022 20:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646972455; x=1678508455;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pZTYLhIbpWAroJHCQZ3PrbZrdKYnWeyUhwfdBkucIhw=;
  b=abJ5HtileXrN85hllyY5DCiGHunfwV4JzwKsJPkgYf2V7NjiAGT6DgA9
   EPJM0wNyDyBXSOlBNqXUMuNJaocArpY5YlI0qQywmD9LoTMW1wBoHwnnF
   HXNbf+SZ982A32jYZeQFQYoTZg4wO9E7bnzYG2kdlC984JifFcZ6vIl8C
   DkdFekRyAv0q1siGI69ky0+VUv0qXH/RFGuG8sNreRDgysRQvP18KH8Sl
   5UKkHby9i5eDd2vS97SUxNyH8TWGQ34sjMTY1KXSxDKF2n/RM8VRX7j8J
   VZgtuOmDylawVaqBfZSpEgLzn5gazRThlVdmMd+nsWCK6IgUq6C/M7kbo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235447150"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="235447150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 20:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="712715551"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2022 20:20:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 20:20:54 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 20:20:54 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 20:20:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 20:20:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6we2jKaG6MY+X4hOx8kEwOXNFL2UgPH9ZryDLQ37sBj9GBD+FxJCz5pNhu5oxyhql6ZSQdCRsHHmeuUzO+M+IFJJsifvLXOylOZtrp7XtnE/rpS59ETsWQkgO6QH/AgBaS8Nj/Q+Jf6/G/Qa0hAgvbGkJpo9huaZP42C5e7mcWqsfl7uBgQEbTxz6CfBaTbjtiIvjLiOO5hJY3UUej181+QfeC0xCbS/lxgp8oUJTfzwsvKTrgIg6vdfYmb/H3ZnQpnxcxbFpg5WYz3CvLdq2cp+1VXosQovxj6RB/Wk42qbDJDaw2m2WJGw+buwD4IQDEYPpH9///FxtlbKcp/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxaLY60LjeVqbUIxnm24p2n5aV/FPKKk1I2vgE700t4=;
 b=BevZxYkG9dQAWzxtVSj9HnECk3FrfyWSWqiaQ1AuUmt2+UENjqrSwLJx7Csyv6swgytXfzHfyboniXS4sH7S573brwBywbvrsRBG9kPpfeb7b01JpUEFzCgihiPBhlM0mbGBJYbNMckifwTQg76pxx/7qwkVTdu+PnMGJL5uX3r4LYIkhnDKmlepJn70CkkbZlidOMi9cORk5yTuHNH19TUoYC+uQeRfAnCX4XHscdaDnBKijLD/WshPaUlyG+O/FtZXFUakxyQupgIyHLl0diu/hisEDCV0ySqOXuE2S/TvASLuPKf2bHLsNxf+N87oLwutJxzk1L0Q4Kl1SM3RsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by CY4PR11MB1559.namprd11.prod.outlook.com (2603:10b6:910:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Fri, 11 Mar
 2022 04:20:52 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 04:20:51 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Muddebihal, Basheer Ahmed" <basheer.ahmed.muddebihal@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
Subject: RE: [PATCH v2 2/2] drivers: fpga: dfl-pci: Add PCIE device IDs for
 Intel DFL cards
Thread-Topic: [PATCH v2 2/2] drivers: fpga: dfl-pci: Add PCIE device IDs for
 Intel DFL cards
Thread-Index: AQHYLpZSrJ/Kjay1fkqud42wnyDFRKy5j7bw
Date:   Fri, 11 Mar 2022 04:20:51 +0000
Message-ID: <DM6PR11MB381933873A813AC366EC987C850C9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
 <20220303003534.3307971-3-matthew.gerlach@linux.intel.com>
In-Reply-To: <20220303003534.3307971-3-matthew.gerlach@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dec3c39-295c-40e3-b267-08da0316873b
x-ms-traffictypediagnostic: CY4PR11MB1559:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <CY4PR11MB15591854EA96396F9F681C65850C9@CY4PR11MB1559.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GY09L2S/d1H5RTqO8EMQOM+u2frn5sOAEQv3wVgPEXpugjy4ScqpWCmYSyeTYL/OvZ172/6G1y3qCoPustSAm1ktZT94UdVSA6zo7k1ZcNnOPnxSdXyYQYg+DT3LZz1vJmc3TVyXka+stquYKEpuyeDQnnhby7fWx4YvdP4J/4Tqs8bxNp/bPZkpTrx8oyoizSLSeIMF05444NBmLRO2qiP0X+84hN3VGAbzuvm5uT/8Ny3Fsummp5Wt/qlSHlivAwUhj834FJgObKQoN6tDYBubXyV5Vi1R2oWGr6aoxKsB83r4YGSOWTSx2pghYT+kcNASwmwP37pPrP5HXlq1gpznTuQG6/lX5BUM96SuFim95hVxr+oq1sT4QClA0WVdG1ECM4vzSzXlKon4lDwWORTRaHG5nodM5x5qzC9sGT4KHk267/5gmGjZ6cjOY665CWAJqKTMy3joLlWK/2ASVLAek9J7JOw2XWviA+HfCkinOw6aXRxOeQom6HE2UEFkTHFh3hFjkY+ku/UTvQaZzblPP/7OwF8ZYP3mr3UPGqQXyQ420hLVrjUAxLcLhda7MT/JkIwDjwOJvMPb4cnxWsE5+ayEZAB6qlGa8d90PAzwXxrI2w5dCwA+P0OqmoEkGv6JfBVZMbMDwsXQGIg3eVnuE1J2I42NeDGPiYW0n/5JEBTa0+fJ1mwFEpeaoAWfsY1zZaYcEONZJ3+gAOmanoafhQmBTtEh98TEtad/rxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(9686003)(38100700002)(921005)(7696005)(316002)(110136005)(8936002)(38070700005)(71200400001)(6636002)(5660300002)(8676002)(66556008)(55016003)(66476007)(66446008)(64756008)(66946007)(508600001)(76116006)(82960400001)(6506007)(33656002)(52536014)(86362001)(186003)(26005)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Uj2LStZKBJiO9dBoUR/QujtVCoLsd2z5jisBTAxu0FTX8idTrvC9n3gglT/?=
 =?us-ascii?Q?qjOhfRw0BKVDl9wLw1E0lQqnbA2EvxqfC94mYpxnq/LGxVLZP018RGcm3SBf?=
 =?us-ascii?Q?K0rWKNWURcq2qOf9jdDlwHaukW3OKhx9kd7Tj9L6KJ/n8KaSrnBniQ9wlHi0?=
 =?us-ascii?Q?Fy/P5lySdVhzUwhsSYtXeL2IGdtyUiM+Ln4jP5EewwGmzD/aVrNLQXnT2Y0C?=
 =?us-ascii?Q?ohGNyVWfj7VCxFboAYo7q88hLSMbrGtx1hqzwy+Y3Js2El4Hamy8RJSeAStF?=
 =?us-ascii?Q?sGS3SwauhidMGSoX3R8v0LY07Fd+FYneANtuf54/OEdnGfjMiHLNwvWIGgRf?=
 =?us-ascii?Q?fvVnufjh1Oqqo3Z74XFeKey+Fr9Q8vtdUvJM+0iODr0K0nw0R5AD0BadQEoK?=
 =?us-ascii?Q?vBVsXxxmtSKqvMZtd2KxSMZ/u/W/0kLbd2gq3UmtGi+KCQBrlOLLXpR2Gcwj?=
 =?us-ascii?Q?2jSVobrGm83wNn82zOs1FnvRMGCdl4pZdt35WWugPgc3wzz3qRZa3D/CPqEX?=
 =?us-ascii?Q?1nEbBWemb2SRRUN+PD5evned0Z+ktAhdgBVyux8xrWsKLFl3lwVVzEfXFm3W?=
 =?us-ascii?Q?ypaYflwVnpgWwkuu49T7KOv1+o0P5QcmWaEbnJCz2BUvj2lj5cuEIw7p2Fci?=
 =?us-ascii?Q?tOMIPsMVIRAHA/+T6hLExsCp0rFIczMr6qWZ7ND7F8mhlbJBcem45tUgmWt1?=
 =?us-ascii?Q?pi2VC0RQIu+WHoX3OCDWHNNv6BSAq+dyMjkZM4NQxZ1WznOUF29oGubjeuiC?=
 =?us-ascii?Q?oQRZv/Tde/U6FE5fjEk1cI0PktmtwahGrvwKWOz70KFueKR+M8S02jeUERym?=
 =?us-ascii?Q?kg1bYyjWu6doz/5DuXq7PpwmXjWtLW7pXX9UVdaATRbIzNqVCgH7ABQFuLXp?=
 =?us-ascii?Q?IOhYdROaziyqHyI9xjIc2IwQMpL/z/xKe2zr8DDq1nGbe5RL5CkoXztSIey1?=
 =?us-ascii?Q?jQusGvL8Sjf1r+gAYNZYsmCFY6Y4oOsi+iQE+mOKK+WwriUTFMgwIOuXKYIi?=
 =?us-ascii?Q?dIyxbNgqucUl2hT3SxJRDjfq1CZb+bn6kdVfuJB8G3vIAVCoFK4ggY8977L+?=
 =?us-ascii?Q?FbHjSfwjwZQyK+1/yeYMfUaqyaBgBmtT7THw8kda+d463E+MsQbDx2irwN38?=
 =?us-ascii?Q?gmYpFso5dRm2nmjCx8pJlGMUh+wIhunToaB8ZHHUQJvK9A2Njmr3q4k1RjAd?=
 =?us-ascii?Q?bj5moAWVvlGK300yRlPNfUQm5PhOXfQWi0WQmSGuAsViI+HnN2GtZDDk12mL?=
 =?us-ascii?Q?6T8cVNCC26RuNkn7Mbfpy0BrYzgl8tAdZUp8IIG26aYImj26iaRb6omhuYxn?=
 =?us-ascii?Q?f0g8nsBW7MZdB66E+HDyt5l/NzCodVQEczrGJbmwlPuCHVVq+ePnwRg//Qc5?=
 =?us-ascii?Q?YgXN+Ixodcj9pLWH0HZqySJDeMel2INj6NNUi0hRlgPNvVImPTmuCb9r5esW?=
 =?us-ascii?Q?2Wx2fY0aV5ZFFYoUrOsZjYybCGSCjjlMbZlWyZWxMlS1//ZRBujT9KsJLNzm?=
 =?us-ascii?Q?AUBEKV5A+5arn+aMaeEBI0yd+x83ZxsD0aBD68/+4JhJHQ1kNMW/DcOqengI?=
 =?us-ascii?Q?ZzFlFWe7Wu2nyEHaYI8MfN9+/nktEihstqJjbFtSNmIU810udGkUi7f46jXV?=
 =?us-ascii?Q?n2XO4loGYfzqv+lvfW8jsCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dec3c39-295c-40e3-b267-08da0316873b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 04:20:51.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/xxP+03xh4LhcT9KZNwgstfIIJ/35Zlx1p8piuqZi0lsC+AUK1dgoNqLOL6gxQjjtZ/8pjmspSTKg/sDVPVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> Subject: [PATCH v2 2/2] drivers: fpga: dfl-pci: Add PCIE device IDs for I=
ntel DFL
> cards

Please remove "drivers"

>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Add the PCIE device IDs for Intel cards with Device Feature Lists
> (DFL) to the pci_dev_table for the dfl-pci driver.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v2: changed names from INTEL_OFS to INTEL_DFL
> ---
>  drivers/fpga/dfl-pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 717ac9715970..8faf284509e7 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -77,12 +77,14 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
>  #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
> +#define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
>=20
>  /* VF Device */
>  #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>  #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>  #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>  #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
> +#define PCIE_DEVICE_ID_INTEL_DFL_VF		0xbccf
>=20
>  static struct pci_device_id cci_pcie_id_tbl[] =3D {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
> @@ -96,6 +98,8 @@ static struct pci_device_id cci_pcie_id_tbl[] =3D {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL),},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
> PCIE_DEVICE_ID_INTEL_DFL_VF),},
>  	{0,}

Actually we never know if future devices will pick this id or not, so
we don't have to enforce such a "generic" id and name here. Hm..
Maybe just OFS, I guess that if you have a newer generation card
than OFS, you may probably want to use a new ID for the same
reason that you don't pick the existing ones. : )

How do you think?

Thanks
Hao

>  };
>  MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
> --
> 2.25.1

