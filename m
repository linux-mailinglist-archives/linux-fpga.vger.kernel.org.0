Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7C4C8528
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiCAH2Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 02:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCAH2Y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 02:28:24 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54C340E1;
        Mon, 28 Feb 2022 23:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646119663; x=1677655663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XfwWBwkDXWZavgNIHMjCmmZPqOBLYMmtdgZLvbKUht8=;
  b=QRlVVqlrE4vtPPiqG2nOCMaj9jjXZxhFZte2KymAMxHEM0RoUF2jVWTC
   n5UbDBJKBBLoRfneyu6G2pIngWozAaVuZTLhBoK/66ZTWTXhsq8L328x4
   oMUtbheTBIWN3LJ31lsutK/6gVvs/uUxbGbJlp86IVmBYbnrHhC49oyHF
   YfkgtUgFYkhLX/qMp0jjjTu8/xXGq6m/eINQEt6nRGZn2wWlR1ODSEcOz
   iEx0fNz2pKgNouKiJxyQ4JAEOuZftoVemU5dD6EPNJaV4m9mudLkMzamL
   2yM91qqbruM9vwQE1APFNxBWZ5rmQi68s2nqG7qiLqGN+3BceENvYXdRv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313797367"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="313797367"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 23:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="534788090"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga007.jf.intel.com with ESMTP; 28 Feb 2022 23:27:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 23:27:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 28 Feb 2022 23:27:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 28 Feb 2022 23:27:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYUF2Z5Afub2JmXoJ5KTMS4Y/KPWM+g+cwFwMCNhJYuzSUfnCBPMeST9CKvE8JepOijvVbbN5dxU89yoSBWJydgawPIGc/aB345vw7fQJ2atjtvFSvcozojfutparp89mP8VutM5uM7N6mJI5pZbTKQL+EiVL+/bP8KMF3aXflnLxxIYcWozkCPxJ9ElsTMBnA8woMBkg6isqs1w66QJTnFbuZvzL3zhmfSnQjR6xDRa4Fs0EQ1BLpqj4h1L+47UmKDvwNww0wkgtVVvzW1fcWw5Zcy37/2ixuPanVgjO2Gr7zTigbEygq8PzK+YFQ5Qideb18hP5w2TTr9n+Hffhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMBirGtaUQJM11ity2AswUAfUlIHRgJVGtvN96tgGYU=;
 b=RPkxhbsgcvwlZ01aggopqjH+UUaZD4mYI/wLfTevNB67ob5xMYP6DotmWWchQsgK3MgPAQCGafXW2eXjZIT3OGzv33nqaWQWOkp7BoasZ54zjJMH2mx3wCJqIAx7ARnphdvLtgXGNGK6MgHJrdM4l4oUkifumSzYGKOJd5irpIfcXCvekTLY18EKfzf1dFGBVQNGYu59OzKUldQ8GJ9o7FPi5o4EDfNBZv6+Cwnl0NjO7or6Zk90zfFH91m3UhhRkfQ7tdNTk42gTw8l0KeiqiwCLJzVhFFTm1wBTVGv/q8QS3hLi3A/7lza7AVnyq3pcXH7i4EBK13lBv82CDnReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3819.namprd11.prod.outlook.com (2603:10b6:5:13f::31)
 by DM6PR11MB3354.namprd11.prod.outlook.com (2603:10b6:5:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Tue, 1 Mar 2022 07:27:36 +0000
Received: from DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d]) by DM6PR11MB3819.namprd11.prod.outlook.com
 ([fe80::e1a9:e3c3:d61d:dd1d%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:27:36 +0000
From:   "Wu, Hao" <hao.wu@intel.com>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
Thread-Topic: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
Thread-Index: AQHYLTUSKJd5cDNegki5Y8Meg4r/lKyqHkkQ
Date:   Tue, 1 Mar 2022 07:27:36 +0000
Message-ID: <DM6PR11MB3819951873CB00D510AB0B7685029@DM6PR11MB3819.namprd11.prod.outlook.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
 <20220301062123.818687-5-tianfei.zhang@intel.com>
In-Reply-To: <20220301062123.818687-5-tianfei.zhang@intel.com>
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
x-ms-office365-filtering-correlation-id: 1905d994-7945-4074-3597-08d9fb54f562
x-ms-traffictypediagnostic: DM6PR11MB3354:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB335416336261FD92442F83BB85029@DM6PR11MB3354.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wAUmhnfA51SAko4kd17rJdobewL0pmCAbjn4dnarX1FB/F1WjiqZPSNjvjsHBLXJDgT5uadwXBVMrV1zUivUPq3k7/9aGxZCzTfvSycU3i7ICwfh69FG8Zw4+cukkVbMH9buNwMmg9Cs5taY6oPwH3lrsyjCe+xjejEZhWEvnX2etsWMCa2Y2E373vrFm+GuFdk6BEBP4Wfu/5ftiYaDeEObBHCcY8ZuEwk8pxN/Dpr6Py+plcN+639XBY2gqAup3scasxJPdYgdUnU8Mf/4wuzorjsCxFAjJNAK+85+giKYFcS1vq9fzXjbbgTeFAoXrPVE7udqOig0Z4dCMMkDDzTrMlPTSWeW5qDjs8eHTbUkzwHYETJeCDB+6zf7sT3qQgYwmPcKl5FdWERUHORysf3O6i1B2fS8nelGXylVDWSL4FP3D1fD5aCvTBFdIKxGqAO+Z5imv1l80ji3RSAWgVFK2ofTHpQqbAuQWlVrgxztIlzgZ1MS1d0DyYsvkaviaFvksfjysE3cJrirG2PUiCF1hgdfztGlI9ax7RmhfMCbcF6eyd+0niSw8KvtxMxTijUkW1AKfrc3dANzScUQ9tun2Opx/hLoDGLsKgNaW0y2JSxcnq20h/QB46af2BLPHIQzwbzY2r4PtfohDLDjD6dv00AJRbhfmRVlCA66r4cJpF8obtwPFXVdBCCoqwAPpgvSMPrETwGuwTnjbMQAVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3819.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(38070700005)(38100700002)(7696005)(6506007)(53546011)(9686003)(83380400001)(2906002)(55016003)(4326008)(316002)(8676002)(86362001)(66476007)(66446008)(66556008)(66946007)(76116006)(82960400001)(54906003)(5660300002)(110136005)(186003)(26005)(52536014)(8936002)(64756008)(508600001)(33656002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mtaIRvd8D6Kb92qW1G26Cps/v+/L7UDSPObWokGjdqZvYLNfnRAethYb6x6e?=
 =?us-ascii?Q?zNyPOzzf7ubyCMaUe9EaHwBK+dPmqCg1qwm9v0W6oVSTOYb0K1Gro3eWsTLI?=
 =?us-ascii?Q?WyuAdo/1QNANSfiF2l+X6QV1YMpUbGfAipT0xt2nzZBc8kyLpMcq/TmIC1qy?=
 =?us-ascii?Q?R4uyCYIQvCW54ISTG8FdoB5NPaAA+eoKIRk/nXFeLSTIVDTVL9GBNXfGnzTD?=
 =?us-ascii?Q?JZX2mLOcgX7zTxUFZg5zW78njnAk5iozzX+3obkUgI8bbN5Sr9JmF5cCWFnZ?=
 =?us-ascii?Q?68OcmMzIxO6GXlFZGugRKYQctmaCEkW6C665JlQWDg2whKNzP1q6GW/7wS1Z?=
 =?us-ascii?Q?VBl0CQlRaT2/LK5YQOq0A0M4As7aJfGyzl34NGh8nl93YWyBCtDkj4W6Crd1?=
 =?us-ascii?Q?UWeqMEYeLHrmtR5IfKswwm0FrFn8rwHVDej9MMWRTf5neY0QmHP3od+WKHuP?=
 =?us-ascii?Q?pg4aNUao8yngDxpg7ZfbEVAcS/GTqWol892BiqVeR5YeGfYNITl9d02KLc9Z?=
 =?us-ascii?Q?WH9KCPZY2QGF1yT9/sAhQLHuf5tVgUg2gVjStwopyDWmybnAJokyqLpi4kMV?=
 =?us-ascii?Q?UgbYAvJH24L2FAUbFP5zxyTgcQHfJInQA8nbmSZyMqUhb7QIS/d43csda3Bb?=
 =?us-ascii?Q?ZkwRapm1WFGvYNEDGlwa+rPVVhas5VDYDfKnav39laXLvS0/euBfll1K9zdL?=
 =?us-ascii?Q?6z5AgSIiGmi9jOcktjnX8uSb96pz/9oFGL0fSuKYU02uivMOqNhFsbRRcSlB?=
 =?us-ascii?Q?nb/kPzEwUXOCg4bXj13c/74J0naPGfiPnvHcKnJdKOoHc8Ar+zFmEjJJ2kPA?=
 =?us-ascii?Q?7pWDDTWmrM61f65pqNzPepA0OoQuSieFUNg5zRwQ0CC8JHiYHR+GibNOy9cS?=
 =?us-ascii?Q?O5DD6VlEF6DPyAHw1cK5qr/Szgw4Q6VNzAFEA9KmEp/oUAaO9JQxLklUDH4j?=
 =?us-ascii?Q?+NZtQ84IjLMincrR0S45I6lBXyle0Eh6KSuDrH8vQoJXzUI9Q/8bNxU03EX9?=
 =?us-ascii?Q?XaXjhirsyYgYgeS4lqWHJmyZe7EPBAwgZgMGExNHT2srad6m2/gB9mmBa38Z?=
 =?us-ascii?Q?zr7plt1V1z5Pse1ruyI/+Culc9ciWrUvgQ258W8iXzkjop657Nh4pbyTyaIM?=
 =?us-ascii?Q?fc4ZrVMsgGh4HJyS3LS6r9e7rNdivkLEi1RJKUOikEiZdOFS3X7T7Tdtq4sD?=
 =?us-ascii?Q?YkigfDmT/L4qT6TbbdJ5b0D0MLHJbsdEq/h6FntFFr+zd7XVLo0cN/Rr9kn6?=
 =?us-ascii?Q?6WqmGWQt+7YGMPspHCn4inRAN5CRILZUJkqFwmg6qyi7oQncJGe9hX8Xp6j0?=
 =?us-ascii?Q?C5U20aHzfXk90sgGTX9b2Z4rAZeVgYJJXQX1TNA9V86oTreoj/TVntTHgtYi?=
 =?us-ascii?Q?D8JDFWmwlKMSyZEPKEbbyeN68rWkwVEoLyskDKGXmC//a1b+e8hpxqyzE8HH?=
 =?us-ascii?Q?DaAwRTvTADKRRSMf5tdezYe526amcuk8hrWnRNwKKkJlHvwoX88BC60ZX0Bm?=
 =?us-ascii?Q?E6eE76JmMFwCxyte4Hsu0d1u1FQGQGrdz6NbP8KZAMG6wBULpbjFU2H/IoMy?=
 =?us-ascii?Q?nzoO1KxHrUz9jesG8hoagML101YSCJTpANI4ApQIUMoQHAxMC5eNgwuTdXLG?=
 =?us-ascii?Q?uw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3819.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1905d994-7945-4074-3597-08d9fb54f562
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:27:36.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95bAslax8gr6Nj9bDgZaanh9ygBEzuucZcm+lp6R4o90a0RMYsxgfK1j4GrEqIf90ZO+5Djgs8aTmukL+ks/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3354
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> -----Original Message-----
> From: Zhang, Tianfei <tianfei.zhang@intel.com>
> Sent: Tuesday, March 1, 2022 2:21 PM
> To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu, Yilu=
n
> <yilun.xu@intel.com>; linux-fpga@vger.kernel.org; linux-doc@vger.kernel.o=
rg
> Cc: linux-kernel@vger.kernel.org; corbet@lwn.net; Matthew Gerlach
> <matthew.gerlach@linux.intel.com>; Zhang, Tianfei <tianfei.zhang@intel.co=
m>
> Subject: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
>=20
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> Allow for a Device Feature List (DFL) to start with
> a Device Feature Header (DFH) of type Accelerator Function Unit (AFU)
> by doing nothing. This allows for PCIe VFs to be created.

Why this is related to VFs creation? We don't have AFU in PF in OFS case, r=
ight?

>=20
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/dfl-pci.c |  7 ++++++-
>  drivers/fpga/dfl.c     | 22 +++++++++++++---------
>  2 files changed, 19 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 33545c999c06..e7d58e7b1bbd 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -275,7 +275,12 @@ static int find_dfls_by_default(struct pci_dev *pcid=
ev,
>=20
>  		dfl_fpga_enum_info_add_dfl(info, start, len);
>  	} else {

Can be something like else if dfl_feature_is_afu(base) following the same s=
tyle.

> -		ret =3D -ENODEV;
> +		v =3D readq(base + DFH);
> +		if (FIELD_GET(DFH_TYPE, v) !=3D DFH_TYPE_AFU) {
> +			dev_info(&pcidev->dev, "Unknown feature type 0x%llx
> id 0x%llx\n",
> +				 FIELD_GET(DFH_TYPE, v), FIELD_GET(DFH_ID,
> v));
> +			ret =3D -ENODEV;
> +		}

But nothing else done for AFU so far? How it works? Sounds like more patche=
s
are required.

>  	}
>=20
>  	/* release I/O mappings for next step enumeration */
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index fd04ef5c8b03..e30bbb3039cd 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -900,9 +900,11 @@ static void build_info_free(struct
> build_feature_devs_info *binfo)
>  		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
>  			    binfo->feature_dev->id);
>=20
> -		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node)
> {
> -			list_del(&finfo->node);
> -			kfree(finfo);
> +		if (!list_empty(&binfo->sub_features)) {
> +			list_for_each_entry_safe(finfo, p, &binfo-
> >sub_features, node) {
> +				list_del(&finfo->node);
> +				kfree(finfo);
> +			}
>  		}
>  	}
>=20
> @@ -1439,12 +1441,14 @@ dfl_fpga_feature_devs_enumerate(struct
> dfl_fpga_enum_info *info)
>  	 * start enumeration for all feature devices based on Device Feature
>  	 * Lists.
>  	 */
> -	list_for_each_entry(dfl, &info->dfls, node) {
> -		ret =3D parse_feature_list(binfo, dfl->start, dfl->len);
> -		if (ret) {
> -			remove_feature_devs(cdev);
> -			build_info_free(binfo);
> -			goto unregister_region_exit;
> +	if (!list_empty(&info->dfls)) {
> +		list_for_each_entry(dfl, &info->dfls, node) {
> +			ret =3D parse_feature_list(binfo, dfl->start, dfl->len);
> +			if (ret) {
> +				remove_feature_devs(cdev);
> +				build_info_free(binfo);
> +				goto unregister_region_exit;
> +			}
>  		}
>  	}
>=20
> --
> 2.26.2

