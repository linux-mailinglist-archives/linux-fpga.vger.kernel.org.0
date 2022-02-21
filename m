Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4164BD815
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 09:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiBUHtH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 02:49:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiBUHtG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 02:49:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2679F215;
        Sun, 20 Feb 2022 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645429723; x=1676965723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GlDIZHX9wkAYESTcnnjezSdZI+TCr7+TmH/oWkoqWsw=;
  b=GrQpEvCxacZMaOw8xbPDfhJ29VHIjTMSgXdLblwWBA3dj0Wh3szYk1jE
   WtBg8Fps1iIP+n43nTsDA1btXYOIStN8YFCVBEZliyQGepfyGsIYG0AU1
   JK65stu76QU8fJH4PIcEOsqxfglIvmpfFRWQvUbB8iRrMmO+JTrChLUjM
   r+1nRp0nxxKaZMbxU0kZOS4STtFYbSYH8kocAud2CsWnbbgGnE7yhMGjW
   +w0DsTlvzA4OnVRmkWYjB1O7AgkfWS13NZZJhyVspjk6DfjWm/u7b8HcE
   y9tSkH2G4SSAms3hn5T4jh2+XGC4z91iTrrUE/Gs18xGKYhp+5/JlZKgW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238869655"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="238869655"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 23:48:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="606301496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 20 Feb 2022 23:48:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 20 Feb 2022 23:48:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sun, 20 Feb 2022 23:48:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sun, 20 Feb 2022 23:48:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw6K9xvRw/G6L7M+7KWUI6RXPoCs+nLHaLv+WAOFc2V8hEzEp9ncGbs+cU2KgKWf2Eh+6HtU7ebHbMWYfdhToky+AJaOJQXZYipSbaATxPvqfJ0YMa6NsVCYLqBGydWrg8MdZJA7LawyzSjFoagSAgyawTrwxuPWed/18dzLnSXZau9TUU2//IJe3mNsiBvOqsR+k+dJMy3bGSiZHUSvZfxlXzc7ZAqsn5FOvjvrZ4YC7NTd2Vm/K5HBNE763jRgniPtqY1g7X1xQp5iOnUjQe3J72lNgkxJsdDHUewkDZ2MYW5JGZvxYBjau0SzF6Ugx6WV6pqqi4uB8WQuB9xyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA5DvAYzBNMN5/URIJtSRfoO9R2DnK8eWmKAJr1sE3w=;
 b=ZxxBrjo8gO8bVdQ4eUB+pH5biSL36wQVfcM1p0W43FNTKs0c6w1UJStnJMttIroYRbQa4jLekOBN2Ja9W7SvMLgOrjmzEeEarSZwTREWBSonKCIf9yfKsDMg69CIAXaDzprAr4lCN1kbkFeACVhyphV7BLphW9iKcfLFjAaOfM2FcquOC157iPHESSLmvW8FJwvJz6kDXdytWMLgVJrRJzXU5uBqmDMkZKyQNB1cElV6QeUDaTJRAYc8jSS6m6cQQM2f1F2KhZ/LUbFREDbJ/eW10iYJXz22u4giM9aiHGD7LedCa0BRZRbbxMhOGDB7uNq9jYK5TBYCQQUmsbF0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MN2PR11MB3807.namprd11.prod.outlook.com (2603:10b6:208:f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 07:48:32 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::8c4b:e24c:c69f:7809%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 07:48:32 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Topic: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
Thread-Index: AQHYIZYvt4gS1fF4bUKEbM/1CaiLCqyVih4AgAgg7lA=
Date:   Mon, 21 Feb 2022 07:48:32 +0000
Message-ID: <BN9PR11MB5483025087E3393B8F69EF6AE33A9@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
 <DM6PR11MB38190E763522052E6C67730D85359@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38190E763522052E6C67730D85359@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87eb2548-bc74-4858-e78f-08d9f50e8eae
x-ms-traffictypediagnostic: MN2PR11MB3807:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB38074E04C62E9DEC54A17F72E33A9@MN2PR11MB3807.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PP0yOrcYccPiwznWkqTAqvYw1l8KQXbbJg+vztqG4QYQrMLZ9khb5ynkG1GqWZUed+BoXJbuX9g/lhqwBdo+PxyrDoUlRSxHvqb5z4j1OjQMKjt+VTo7C/FiuJeVY7iOz0tI5mvetnFNdvANsmzmiyIBhprR9gzBpdtGFnwf7Qe8TC3B5MGt3qlxlb3XXwQFcyPaekBx3w0wcCHu/ezu0Zt1l06DWcocjI1Gt6PksioJub35YVA5VWftyYem3QZlhmxliX1GDNoSjx67KN7FvfSVVSy5zpcPcJu32rXXrv9kJw1qEPYSkbl1qJerAGxpMetUbjOP3h/YSj+uhn+mjkHZTiYbAT6Aaqi0lc4UGrya/lrG8Py1lc40qBAsQeHM4UfCFtik2ccIjhCXICsA5rV4iNq48ayaNycT4hejiaMhcU3oiPlDBQASr5b7GSkkaUBi975maqNTUZBBhK4XNahgFSCfv4h403m2AA+M5czzXNHkGtotH/htrIM6KHYUJgN4FXz3BuApnJRJssgNo61F/6CWsZ2SUWiJdOL6wa0IhlHC3tqbXzKONEs9UVBdpaKh76H2hEugM5u6/nfOtCHBO7Crk0aPH6pepNUCqUFWpmNQ1H8wFr/1z4C8ijIcVT/3la32D3pSc9YEPXU+OgpK+dLJa5zFHdAfKnIjbIhTWn2Kt2FcBifddRhTrANj2pgtdu10WucPCVfHEd7oLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(7696005)(53546011)(5660300002)(6506007)(54906003)(110136005)(55016003)(8936002)(52536014)(26005)(66946007)(76116006)(8676002)(186003)(38070700005)(4326008)(66476007)(66556008)(64756008)(66446008)(33656002)(38100700002)(71200400001)(9686003)(82960400001)(86362001)(316002)(508600001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NKj8tZIFWDEc7ipzP0mDTm3oRfb5wdq5dSh4VRhkR/i2YlRkV3FPA2Qlh+vQ?=
 =?us-ascii?Q?c+SAsIZUP6ENaXy8g+ZlUop5EN/m/rFLtzATb/Ml74oVNEjhi1dsbaxPNf1k?=
 =?us-ascii?Q?Siywct0wD3ro7bEEALiYWogq0N80B/8S4HDTX8YZAxh37fEAJLTEjxWayCca?=
 =?us-ascii?Q?TSxayinrfe3wjpf8FIlssRoRj6310aaIMV0xUbkVQ08xfliJoADTHNVCyVhw?=
 =?us-ascii?Q?5iu/ypX+cJPhC0V5bENNmgvBak/e3eiwdyUIFrOLhVwIyhQYstjXld17ltJa?=
 =?us-ascii?Q?mroPnrKHfeGEz9PTHssLxKM0n0aNZMyPb4eS9kj76D4xcqtFMQb7IDgsZ2Ep?=
 =?us-ascii?Q?dDHGsYSWIQlLJ1vXkv8+XDCR0ohUwXgTIfiPqWeqr6p5guRAIpmcvObsswlK?=
 =?us-ascii?Q?oaBE+Iq74l1vY7vEQ3DpZQkYfV6dvEbYjK2L0NyOHvwKaRi74ArPsfxH3+F7?=
 =?us-ascii?Q?WuYJb98EvL/crbQip7k6hvRv5SpxruJmWpjPcjl6dZDqKZXHzzCFcK2KBosL?=
 =?us-ascii?Q?4WrhJez5XbnAULp6TRT6PQVZwDlhk+LWx1rw7ywP/B8Xes9DM2yQzRz8HgME?=
 =?us-ascii?Q?Oc4OLrCoWtyD+xSSwIVkmoJNnYd17h+W4k5XZuMp54QNXLsA2gQWh1V98yRh?=
 =?us-ascii?Q?b+4EE0zlnGysww3FNEzZ3Uxq0OKz150DSgo5fRJ15xPVk/rZeFnVWMBbkmQ4?=
 =?us-ascii?Q?YkFTDvjlxEeUKa8fRPLJlzV89zwMHwNH8I+WPGgJhHBiAGx98lFtEUAl4yfa?=
 =?us-ascii?Q?JkHyLW9ctSfGiwmpErBny0h+CCmKaGxfqlDVZy/1ipbn+8XGvdHW49Sf+Suj?=
 =?us-ascii?Q?YK7uUCFt5iDvbHABq5abcNat+cYn0qL6GENa2NhTMOA8tYOovK2p/8yAcsbj?=
 =?us-ascii?Q?52cQBMHC3kFMPamyHAKS2CG+cQef5aHLqPEHCUkmYSyr+tFb9Q9386dbezgT?=
 =?us-ascii?Q?Dpy24dojYLzCDut17vS3ACmt5EvXU/zQFAnfz57CXnjLVbWB8HA2gnqzbqyr?=
 =?us-ascii?Q?CPHfdXieaA20cDm/5TR0bgB778EWBTuxg634y49nbZ6nB9uMyWr2ZaJ4WNfV?=
 =?us-ascii?Q?136+4SjMHb34Q9+7n4AB83YhiBWB6+YD1XcgZ+e8cJWbDCp5hrLKUdXXrHoc?=
 =?us-ascii?Q?N5VRzA8cIUzL05TeRzYv0IZLw945hM8T12UZF/3giCBxWtys+UKXZKMvo1EI?=
 =?us-ascii?Q?Q5iTfrKb7DtpxX/hiqZt1abpz4L1MI5W5FMmqebUsGsPqk46amN+qPpf7Crb?=
 =?us-ascii?Q?H3MbEsleNO1JzqSMFtiFpIH9Q/FcVOsDzMSc0eSSHcmwPt9H7ovO0mk2zAKn?=
 =?us-ascii?Q?8FaLpGQhAnmswmEKx2F5/CBqyKuL1XawbM4CMtysTdt6FHGS4LGlGiLLRyP/?=
 =?us-ascii?Q?2G89pGDddCTGJB4JconFD4abH540YbEqIZwIRTFclxjH1AmUSx47na/8ohLZ?=
 =?us-ascii?Q?bFsNkEJ90lnIC6FFkRInM1Js3d9yIE66ddTtkISLwYvV3CKLIhemdKiFAXtQ?=
 =?us-ascii?Q?St6oUC8BJ6K+dcvQ16izzUI8gbnbug7JkQhjbdKSwhitLzzsKy5O5CbOxzWf?=
 =?us-ascii?Q?XsJ8h/CAubSU2RuIjA+f6jmK5z0xdnp8LmqiJsDUxFpbFfjPEkri9O9eYR/d?=
 =?us-ascii?Q?CvYviVyV5BidJiCD0CMnToc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eb2548-bc74-4858-e78f-08d9f50e8eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 07:48:32.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DByI42jmObCWKxOPmm2AAsCfYtyF9zSRFXVbMQL/IS7Hd/7TC4U5PeQNfm4IOt/60mjdSLotcNyAonwMWy2F8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> -----Original Message-----
> From: Wu, Hao <hao.wu@intel.com>
> Sent: Wednesday, February 16, 2022 11:38 AM
> To: Zhang, Tianfei <tianfei.zhang@intel.com>; trix@redhat.com;
> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.or=
g;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar =
space.
>=20
> > Subject: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar sp=
ace.
> >
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > From a fpga partial reconfiguration standpoint, a port may not be
> > connected any local BAR space.  The port could be connected to a
> > different PCIe Physical Function (PF) or Virtual Function (VF), in
> > which case another driver instance would manage the endpoint.
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
> > 4d68719e608f..8abd9b408403 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev *pci=
dev,
> >  		v =3D readq(base + FME_HDR_CAP);
> >  		port_num =3D FIELD_GET(FME_CAP_NUM_PORTS, v);
> >
> > +		dev_info(&pcidev->dev, "port_num =3D %d\n", port_num);
>=20
> Do we really need this info here? in FME there is one sysfs interface for=
 port
> num.

I think it is not necessary, I will remove it.

>=20
> >  		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
> >
> >  		for (i =3D 0; i < port_num; i++) {
> > @@ -258,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pc=
idev,
> >  			 */
> >  			bar =3D FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> >  			offset =3D FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > +			if (bar >=3D PCI_STD_NUM_BARS) {
> > +				dev_info(&pcidev->dev, "skipping port without
> > local BAR space %d\n",
> > +					 bar);
> > +				continue;
>=20
> Is this change for IOFS? From patch #1, we have FME and PORT on PF0, so w=
e
> should have a BAR for PORT on PF0, is my understanding correct?

Yes, we have a Port device on each PR slot in IOFS, but for " Multiple VFs =
per PR slot" model,
the Port device would not connected to AFU/PR slot (the BarID of Port devic=
e should be set to invalid),=20
and we just can access PR slot/AFU resource via VFs.

>=20
> Thanks
> Hao
>=20
> > +			} else {
> > +				dev_info(&pcidev->dev, "BAR %d offset %u\n",
> > bar, offset);
> > +			}
> >  			start =3D pci_resource_start(pcidev, bar) + offset;
> >  			len =3D pci_resource_len(pcidev, bar) - offset;
> >
> > --
> > 2.17.1

