Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8912C577A17
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 06:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGRE2A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 00:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRE17 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 00:27:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4FE028;
        Sun, 17 Jul 2022 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658118477; x=1689654477;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=90P6pQAJwdW/mwcL71CfVSZo0O4cicHXL75H4XFCGx4=;
  b=jXBwGgZaTFKNKINK96tPfHxKMeOBWl38hwQdmeaXyPON3a66x0rVXjV+
   Jq8ApKLmPQvw/ddYglhh+CKlveCvJhCTmUIWfwOtY3QdnUJqE9Fq9hqSK
   qXqESBcFSKMqCjMM+oD0ROoaCCYAJ/Dz0QRig0cHa1cygpEuciiTLgTn0
   BoXwq3341brGVZNTYlEwpaNz1EeHbUwy2DLQ4KyfRfmNHMArEYh/wIdHJ
   a0EYbu4ENWUTB0AsDeYXgXvqqZ+8YhqGFxiPdLXjxqQ2aOn/q8JDt1xlM
   o968AYJjA8tCFvXnoXH9afz4Yp7mcVKkdZdj5TX0rckEjjx9B2kWucbpg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="311808185"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="311808185"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="924187006"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2022 21:27:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 17 Jul 2022 21:27:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 17 Jul 2022 21:27:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 17 Jul 2022 21:27:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6YBmnR7M4gO3aiPeJT+x/pXm+J2i3UUIUQoPrnOUqEs6Pp4AzP1HKAe+qdwoPHIPCeIiTSo2BYXmo8vixBoYaz0UPLcHz46nWwAfALzwy5wilzXMLe38yztrgWqHBpkUI+XnIde/kT3FzETGLW2bD2DHZWmdnr0naM9Jshxq9n/Rh7RSNWjK4lfUAiuWrxqTBQQBGi/o5gvFxVgLJ/KNNcNfQwjThihMuZyr3xtGgptxolReBJ8E7ggphkWbPO/7q8KMRqI+C20cc5RUlDTuG0GooTxZX0Yip/PiLiL6WLjIlnedNGCQ//B9SfMJGi9IKt6OAz87rTIczOivv5SQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLrkSaFIioczV/SJr1IS0LFSKrwaDBj0+JUa31aapK0=;
 b=g4jaEpNaQ5MoKvaOf4Tc8VUvQIvaxBDQ9TzTP6WRzzMVuLjNkdasMBOzM3UciCiql6FbbiRdjlR4V+WY1BLeQxthn5rLfe8OCntKksRUmzD9SvStYeaDk0iQzVZhyU46zKNZoxzGuvhFH7DhBjiKAVRHichLmKEjc961UQ6DvW38IulG8XR5gQJZMtTtuR8UQl+3hCfsJwBNp26kPZLtOzngZDRseAS0lSow2YWmWO4Whot03EFuixHvNTkSmNFEmcrnV4DEy6zhaO7//eUMfWUuKzIM+g/ij4Ox8o1h9xOpsDpsrXZEnuDvhw4kxDisttskGAxkozpCDTs+iHqzFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Mon, 18 Jul
 2022 04:27:54 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::cba:2a0b:8dbe:ca9c%7]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 04:27:54 +0000
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
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
Subject: RE: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and
 C6100 cards
Thread-Topic: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and
 C6100 cards
Thread-Index: AQHYkhMVsoLbDKGMDkCQj83FX47Tpq2Dl6/g
Date:   Mon, 18 Jul 2022 04:27:54 +0000
Message-ID: <DM6PR11MB381961FEAAEC946E46562C83858C9@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
 <20220707150549.265621-3-matthew.gerlach@linux.intel.com>
In-Reply-To: <20220707150549.265621-3-matthew.gerlach@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b5f38b8-f98a-4df9-5ec4-08da6875e28f
x-ms-traffictypediagnostic: DM4PR11MB5567:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30p7Kf4R6C3rR8LnJXEyPe7+CjG7u3uaWoIPsyUyOwEtDWTHvUVMGGEd5xx41xJijF1z9yd3baQN6z3H0lFbnRnazOLj2NnXq91607uR1E+8HYsk3oRs+0vElBj/+8uP661YELoyAILtUJoppiFM11hgR3GMdDoB4H7nZ6b09+v03n/sfMYFxXQjyBMAR3/B1CE/eadSQ1+8ehOPblXTubSEYgubm+Mm1MJgUgmatQvwIl2aMNpvVKfs6MojZeiWDd6BTsMz/CKnQ9aBIb0ELRIVVVzmCM4E5aE3ZI2UD+mM5ErvtRxUjC943yFDfCiwGQFMFTgPjxi8WHv091LfEH8I/pOSw3AA2rZjRZ+QeyrzcgWLQHrJPBqXIFocsyzZxlf0EUbSiEexQYPv0EE2XzVpAI5nv/NjUp8k2uQm6hNWOyT2iI2lAO4BeT8qXNtd9AQgvnt93uX74qzo9e5FCn7zfRM0BInRWQAqzUTXs0zbJexJRo0PH9jiH2oc1yIGqkmiV72iofkvEObdJ6eiyUN6f4c4LLu+1y51QYS8fR6YH3Ozg/KUdlt6E+yCJnUZI2OY8SWC2SuGDq4KBYtuHDH9XH+shZvfoz3qTae+ocxUbABbNIJjup/lfK2I+sdK54bQHsYPGxrIl9g7RGowIfefGLfznB6eec/fVlYu15jAknJrCIRLxy7AL4YEAibv9rm/EN9ULlwpOXqmTg8BRvRnohSYDOjZGgjc9pgQanOzsiJeiE5N6C/YOLv+sJrwTqCRtbr7vifWOscO2rtxWwpS360OnD2AKXZcgiDNqqRUMUqOBwI2q03FZBW96e/1W03ovrZ/KLi/btyDDwaz6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(396003)(346002)(366004)(83380400001)(9686003)(26005)(186003)(41300700001)(2906002)(33656002)(86362001)(7696005)(53546011)(6506007)(478600001)(5660300002)(8936002)(52536014)(38070700005)(38100700002)(122000001)(316002)(82960400001)(921005)(6636002)(110136005)(8676002)(55016003)(64756008)(66446008)(66476007)(71200400001)(66946007)(66556008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HlMpPQrnJ5/fjxom91cFRLVqb+yJVdRjcLHOO9wgEwVi2Lwi1OgNhsqv+ljw?=
 =?us-ascii?Q?Z4c2KaBaDOZd3D1RMW9KJcDqGUiKXA5GM76n839QPuzn6dCinuTdjJi0oZKD?=
 =?us-ascii?Q?WhJDfVdW0pwyyKM0bFqpAHy0kEziTmxp3HZ+mFeSZou/6YqXs2A7stqeaOEa?=
 =?us-ascii?Q?KWGH000vxpW0BqlS1hAeTVTBdROiJxPyEEhTf9uH+PZQXBe5BgtROX0y7wDd?=
 =?us-ascii?Q?fTGyyFHi+f9cJYJN8/HonEoa3dE1ec04iFKtmzlf3E7yEEBU+x8gNAzneWKi?=
 =?us-ascii?Q?meIQaahjW+I8Angv6EJG8I9hco9+InKVUSn9TX9RoL/pmdZzYRuhXhvKNgHl?=
 =?us-ascii?Q?WGrkdLsR5+XfX1NJDmFB+MH1IVbgpVoIr0xi6cXGo8+/vQzkTv93VsZocmJL?=
 =?us-ascii?Q?MVLHDoaI7a88UK44/HEzDGUZ/zcSACiuH0FERPTleI0eck5NWR9o0qjMkLmj?=
 =?us-ascii?Q?I63EHDNbZCCOPPh774jmwBREBIt7D1geHrt2vzbhy/wMNWOyIpuu9YasZU03?=
 =?us-ascii?Q?Ari1bA393Fgtx/unEggQT8f9MZgCk5KeFIWTN9O/dEYM2U0SSF2NEVZ4CDC8?=
 =?us-ascii?Q?syoXNZrw7ir4O9OzY0Ktp+/EQI0RZMuFCKOmUrNXE6CoRA2H1M1Io5Kcgard?=
 =?us-ascii?Q?y5ie/Ik2Gc7XCZUnnP4iSf6NnYbAym/FJZQ6K9GZQ1/GkQRQIL2q5+KgRwlz?=
 =?us-ascii?Q?wIW19ASZFcdLUZ0K2mQU7HlSXfL7SEFY9BTqIoEYnTqmg/iK82rtGWeg97Jp?=
 =?us-ascii?Q?hUarl/g7lQBqDHe4GPYq4yKCMFsDCrS+5yy9j2vTo5MCvE5wG37kUsblBU2e?=
 =?us-ascii?Q?sRTJY2Sh0bcNCBX7zK/e6A5C1eGA34HIuB8eq/mscvIBO6mJMIf8DCeFjynu?=
 =?us-ascii?Q?GxYHTVbUmS5cpsBA6OclaWUbOlC9fMAv++vMFFq3YSoVvx550jEq2WoTS/VN?=
 =?us-ascii?Q?+WWLTKcYs7XqTHPMfdf/89GmLkB8iYMdNG4mUjwnGKWVgAUqdTO7Z7ZPCLQq?=
 =?us-ascii?Q?TH369Od+8kxmDL00j7Utr3rbhdzOPYWIo7ZqAKp4WfpK46HEHzLiVNFb41Iu?=
 =?us-ascii?Q?Ps1u5dKHM78H0QZHxLEqcB0bIj5cUv6L0CSOtLIsFZRcsahpd7ZAveE9fgy6?=
 =?us-ascii?Q?OCDTWwpzyUDEH7gYf4ORGkv/ShR9lR6C5XJgrdlnYSjAa/kUHf41OK2fX/ZD?=
 =?us-ascii?Q?xehWjraYSpZtR0wQqNjFuNTrAc32OQ4OOtpxiMIZ4pJxnS7giTsadnaFwMp1?=
 =?us-ascii?Q?FRGorPudyS67F7hhnulC15UNIrCkd2YfEZyHjRQeqsZ5r5w92xWETov0j7ps?=
 =?us-ascii?Q?WfsS7udGma0dqIS4BjL2CCErPlTWTEyAmg2KAOgLO7/A6LXRHgRjikxKoESX?=
 =?us-ascii?Q?EoN9tcSneIl05emv+C8aSqqPm5kgW+9DceaHkhvdpg34MAw93KYIZvoHcSM9?=
 =?us-ascii?Q?ELMoVZJ6FqI0sxwa88KL+hlCMUw/LDj7qQCfOZpRXPiSBPn6HfgQ7t2CxK5F?=
 =?us-ascii?Q?+WAQZ0+ZkXB2GkxHBgP/AsSv4hWcQ4DYFPPK3KWtXZ4fxvlyfe9kNLoUY0i+?=
 =?us-ascii?Q?oEg8yeUkCck4Z/ThxGU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5f38b8-f98a-4df9-5ec4-08da6875e28f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 04:27:54.7386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LL+/LgRU8BxhTzcvDEFuQAmdbe1qQsxe5vaWy9MERLU80OnJTkRhRDeVYUw+bxjPDQ+Y5rF9CkB98AeKyUTR5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
> Sent: Thursday, July 7, 2022 11:06 PM
> To: Wu, Hao <hao.wu@intel.com>; Xu, Yilun <yilun.xu@intel.com>; Weight,
> Russell H <russell.h.weight@intel.com>; Muddebihal, Basheer Ahmed
> <basheer.ahmed.muddebihal@intel.com>; trix@redhat.com;
> mdf@kernel.org; corbet@lwn.net; linux-fpga@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Tianfei
> <tianfei.zhang@intel.com>
> Cc: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and
> C6100 cards
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Add pci_dev_table entries supporting the Intel N6000, N6001
> and C6100 cards to the dfl-pci driver.
>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v3: added necessary subdevice ids
>     removed 'drivers: ' from title
>=20
> v2: changed names from INTEL_OFS to INTEL_DFL
> ---
>  drivers/fpga/dfl-pci.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index fd1fa55c9113..94eabdf1d2f7 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -77,12 +77,19 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
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
> +
> +/* PCI Subdevice ID */
> +#define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
> +#define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
> +#define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4

Please move SUBDEVICE_ID above together with DEVICE_ID.=20
If we add new SUBDEVICE to some other device like this, it will
be hard to distinguish them.

With above change.
Acked-by: Wu Hao <hao.wu@intel.com>

Thanks
Hao

