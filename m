Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D925066E8
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiDSI15 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Apr 2022 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349846AbiDSI15 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Apr 2022 04:27:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EEBC38;
        Tue, 19 Apr 2022 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650356714; x=1681892714;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mr7NWpzJtoxsF8R73t8OHJ3Kqx2AgWs9cExzJxVDeS4=;
  b=myJt6k6dkUBomEaKqd/wjlGJDV0jElqYx0BEOWKK03bPtTbSeo8b8nhg
   3ZswsMl8ARiLzIowbHof+AItUm2bzYp40C6YxHGxmmq7blDca+4sU3cfQ
   1+UVITWWHwpo0McoYIfeKwZ14uTylPntXcCb7ELPBfWJOsFllmw1WIb69
   6EYTmDsqmVn+NYMYowzcUL1cW2Ef7v64eYmb3suxxElpTuyUD/F35kU0/
   b44SeT8+2aoEvTWAqH6k7bdU1r2CJ8JwgjqPwMeEgT6vTejbrf90guV1F
   XzhRxEV83ICzA3WbPqWWrQ93DgAK0I9Wsjzq/q3JUovBBmUlDu7csQK5L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="326609574"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="326609574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="647181103"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2022 01:25:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 01:25:13 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 01:25:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 01:25:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 01:25:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7EvaB+GVt5NNmJ0cHxXEZMGRnob9ZhnBTpzZMeeG2VnQIOHfVl2Q7pYsNPTi+Y8n6j00rf2ALjiRYvQOZMaE5+R6bCgVvlVxvVOilsgsiEjaeew2yRzNWoF+boJGYnVx1JZTm1ld+XQIRkNXC7gExG0DQi6upuFGhPrcgh8kmsXIyZaFcAAIjcJn0Bq45AInf0QsQJN3NLYq7ICrpxwak7vnyq2dj8cL1FH0j9v2BWVAwhqqLOpHjI8yCzb2aWxEGEKP37UofbB6Ig4rpHH7mX3JObBtHDWVRzYh94wo3+xZTyytNc9GeTCJ960MPqk+mF1+TkklFDPoblK2NCTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFi76f8ehE5wOKcCiyFBsoEmZZSgDx4Xmqti7zv81Cc=;
 b=aclln51K4j2cSHiu//NjgFNFnNDdgIQ6Zj1cUFf0g5cHbl8xzZelgrLae+aUW+del73PbIRzHAmVAnJhQBv1+2lyXka3IElJYTet/bMazI9vnsWXKuEWSTCdLXS0lD0/mx4iR5MdY1C3xoiB7sSW7ib3K3hpb0L+6Q4KFuZA3anGIjPNk/cYaE8LLAAGs68LfeInpFrRpnED1vTxZ6qjmZBeB17ZI/i0OWzULKi5GKp1snJug27HxlzCWgDbcDs0AwcxC+4aKhormZ0q5MaqrbK5A9jdGyBOV4HhEpmu5vhpw94hSbqxYMVvq1Qmu+9/5YXzfuhBviDE/b3y8cf8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:25:10 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:25:10 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Gerlach" <matthew.gerlach@linux.intel.com>
Subject: RE: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Topic: [PATCH v2] uio: dfl: add HSSI feature id
Thread-Index: AQHYTjZdVn4DreM1yUm1T9RcZPeV3qz069sAgAIEAlA=
Date:   Tue, 19 Apr 2022 08:25:10 +0000
Message-ID: <BN9PR11MB548330FAA7EF6B9DAC2F0E76E3F29@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220412062353.53984-1-tianfei.zhang@intel.com>
 <DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06b842d5-15e2-4fbd-c788-08da21de1e9a
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB5866F40C6719FB1D37DBD1BFE3F29@SJ0PR11MB5866.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9CD9xX55hGWwHNpVl+U33dibPhd2ROSjjvoI3Bkek9G9pUOXh0SLPzHukxu3XHmGgQoSDkx+28nRxzKrvoebB8nbNK5fbYTnnyUDT5yNug+jGzbXNRBdrKTJTsBN2VpjUkYL3Fc5Y1bB0G/U7aYpy90K69WScz6EFX+rTOHs2ojwk1u3qoVB0A7MwHFd4ZvYJ7qMAv38kg9Yjug11ZYdJmmIUFPCWcXP6dFrQbSBgAUK+YBbzo2VzDIJSDFoWGtWYhVIWbnUkt15Nnq/UvxAXTEk0HBP6QREy0aXosQeKNU0imfP2+C6vO3gxYNVcx4+1kBVh8aYxHefK2tF5Ruz9m7tXnaKNr/Pp7jhaPTUnY/lcRpbgDnUIJEuC9R7a1xh5gtMRvOfrgdRXhn4aneJg2S6hmFor/PVZ4DQk0KEtbxGLdoeoyImRa2KQksDY1TvIU+GTMz3law1ctUA7mkFYqG05ET0VEs2o7k8sMJ6fc3d/3Er/Vk3xfC7cyYdDpB0IInufnzCPbe4SjNFjKjvS50CSR6zv4Epjazdm4BRT+VPRiMiCFYmFKuzGD43bANcphtgdzEFF6PPzDYnSa9S+AS9O22UqShK5BXuA30TV/QdKLGdmc0X/IY9gjAj7Yb6jop7It2O7hOSMhu3yCYZMEpAwQYgn12JzSku0CM7XcUddZ+HFU1zXIC+9M4ow71NnpjAvrrA0UYdjftWPp9CnV/n8DvP7FiqAvIhfvpqS7NMR6nxQFwLj/7CNIcIe631JZa/vTX9yg5/malKEZNNHuGF0HLNVkzUuasmiOZjyyTc+ByfYdYSBKie+WYeh95
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(5660300002)(966005)(6506007)(82960400001)(55016003)(83380400001)(508600001)(7696005)(186003)(2906002)(38070700005)(53546011)(71200400001)(26005)(38100700002)(122000001)(52536014)(66946007)(110136005)(66476007)(66446008)(86362001)(8936002)(54906003)(66556008)(76116006)(8676002)(33656002)(64756008)(4326008)(316002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iAe4T6CSsvSjSJqU7mgX7evkBqmrY+jNrYg43ggDrAsNIMWPoLce6ag5s1rI?=
 =?us-ascii?Q?hCV3zU4jJVz+tDTcD8zRCvGWgRPNvDMxqwA6IwE8/AEi3lzpCIrI6O1fxle2?=
 =?us-ascii?Q?b333tPPwtJ+yUMxPJH6MerrKY5ZtTtT3rHVO+avfWg+3p/ta0yRcuOtjplPV?=
 =?us-ascii?Q?R0BnoZAGE/4mxQdFHrX+2tdJj0iG0svlxXZV5BcOaIBPhNNyHZbwe2zZbi5b?=
 =?us-ascii?Q?+BO180jKAcDP1q6Y/XRKAPBqzciez1uoNKnxmfcQO+7QaHrkCaeByM9wwzD5?=
 =?us-ascii?Q?R/BLEGcF9z17gTGRGPNaayZwYaLqMvctavu0JSUSkFbYI3Ok1TOvZ1EjPzl3?=
 =?us-ascii?Q?ecmINtk7E3T79FaBK/08oIPKd+m0MALHvAICjftpb8APkS3OIoCkz+i/S1zw?=
 =?us-ascii?Q?R+yrpv7W5NHXvTwWoL8+g9n2KICIMIIDD7zGQ7mh8x7n5gmibZIVS+66g+/j?=
 =?us-ascii?Q?4d9Q+nog8JDhBXZGTE7XhVW3ZEwV5zCmXQbxOR6r/BBQDb2ayn9BQwVK2A5h?=
 =?us-ascii?Q?DNchR6p7K4n4OT+DbQTCqmsh5bd/EaxVB4Sp9I5q1PiD4Kk7CD+3BTXII4Or?=
 =?us-ascii?Q?hTbGxDc6GYbduUFqj6bQwxM/RUMbCyN4y/yP2zoafj02BlAxh3fbPnnhV4bT?=
 =?us-ascii?Q?+4HAC9jJtx0zgjD7fsZ0E8dYZJzjb9Oj3uPrSfdJghSuxX9273x3jqCpuq0F?=
 =?us-ascii?Q?lYwBRa0I/HetGsM38H5jkLijyUi/TOkxyagNtq08B6SNVFN/w4EBv4KrJdOI?=
 =?us-ascii?Q?O9XJPERnPjnsF0jJjAdm1y7IiT5gweXhEAPMebNdBgE49SuD4+6ADmI7KgFQ?=
 =?us-ascii?Q?nnVYJ2hVVmQKKKBR5NJ67+ceRpAg5hHM/6Dwm5ptRR4lTmY7vdmMa6TqXL6E?=
 =?us-ascii?Q?PaKDNbsncJasYW+vHX/0AcLEFT+Asa6ie+68/KyLLj1B048vJcu3CFB0mrte?=
 =?us-ascii?Q?si/p518nOBJIeMgurJNHJ82CEc18OeM/V7OWuQllWVGZ8nkwLJdoXyXYSsUR?=
 =?us-ascii?Q?rTTYNENCI/G17NqLvLXScrOYhiVgWb8m1TtOcKM9wCEUHJPaKxXimR/r69WL?=
 =?us-ascii?Q?XgX8xj8sW5cXM0iG68f6DITljw5gG1zbiv+8dNY5su6EnGH6Rs5M9wELxtMn?=
 =?us-ascii?Q?ney3s33g5MyZPA7rwshYl0n8hgyF4JBz13sBhRoDrSfvXIvfnYHWn83/JLM+?=
 =?us-ascii?Q?DrmwqpmA1d6Se3gtYNF63dFLW+RHu1BD5S+PuJGpMI4x+XW0KbfZpK1hGfsw?=
 =?us-ascii?Q?/yhlPRzNfffrqSeLAC27/QRlQ0JAKcAneSlSNm8moeANRbLR71wY2E3kgbyh?=
 =?us-ascii?Q?ictmTaGLBOou3UNDNI1Vs6bbCaxU5GLkaGZ+FGhrFGaQ7Z406r4obkQ/Ykpj?=
 =?us-ascii?Q?rDR5iJeA2au3xChT8BGx8ccLbFWEeSs76cDiwXdhsHmpLDHjg3V2T1xI5Uqi?=
 =?us-ascii?Q?p0KfUc0fsLQ1yumUsvOkUH3XR1xL7+p72CfKC1MEbCzoq/cZo5yYs261Jkzv?=
 =?us-ascii?Q?DjORdS16yPRfltsVDYzswRD2njnTt41qchpaGpA4dWvKSqt8zoWxNT2OHfnZ?=
 =?us-ascii?Q?JdiNunUi+UP86YF41nRIGx4hzswonQBdAWmPRhDYuWgFjKl7Gw1uvdc04m50?=
 =?us-ascii?Q?Z0Epk9xnobmI5DdtiKRTXMHm0E2+e/RfshL/x6o1EpVQ8XpvyhMEeQiVJ5C3?=
 =?us-ascii?Q?LHEh+LiYDEp3rS2iSWEL6q86aL4O1sK+/Ecbbxit3BFPboFRgwu8gmZvj3lu?=
 =?us-ascii?Q?RQVaEXgq6w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b842d5-15e2-4fbd-c788-08da21de1e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:25:10.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Im1XdSHFtpZrN85JzOxwpRBdQ93L6mpL+anqvDtdWQ1qeoBtIGeU4mZortZLTJdDPcO8kVnBtdcx4drJ1yvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5866
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



> > -----Original Message-----
> > From: Zhang, Tianfei <tianfei.zhang@intel.com>
> > Sent: Tuesday, April 12, 2022 2:24 PM
> > To: Wu, Hao <hao.wu@intel.com>; trix@redhat.com; mdf@kernel.org; Xu,
> > Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
> > gregkh@linuxfoundation.org
> > Cc: linux-kernel@vger.kernel.org; Matthew Gerlach
> > <matthew.gerlach@linux.intel.com>; Zhang, Tianfei
> > <tianfei.zhang@intel.com>
> > Subject: [PATCH v2] uio: dfl: add HSSI feature id
> >
> > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >
> > Add the feature id of the OFS HSSI (High Speed Serial Interface)
>=20
> We still don't see any description on what OFS is here, or will OFS be ad=
ded to
> title as well? we don't expect another submission with the same title but=
 for XXX
> HSSI again.

This name of HSSI module in dfl feature id table is : OFS HSSI subsystem.

How about this tile:
uio: dfl: add OFS HSSI device id

Add OFS HSSI (Open FPGA Stack High Speed Serial Interface) device ID in uio=
_dfl driver for Intel PAC N6000 Card.

>=20
> > subsystem to table of ids supported by the uio_dfl driver. HSSI
> > subsystem consists of harden/soft Ethernet MAC to support various
> > ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.
> >
> > We leverage the uio_dfl driver to access the HSSI subsystem on user
> > space, because the HSSI subsystem was designed for specific purposes
> > and does not fit into the standard MAC and net kernel subsystems.
> >
> > The Feature ID table of DFL can be found:
> > https://github.com/OPAE/dfl-feature-id
>=20
> Why you put it here? even this link there is no more descriptions to unde=
rstand
> what it is. Or can be removed here.

Yes, I agree, I will remove it.
>=20
> >
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> > ---
> > v2: add HSSI introduction and the git repo of Feature ID table.
> > ---
> >  drivers/uio/uio_dfl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c index
> > 89c0fc7b0cbc..660e1d0bf6b9 100644
> > --- a/drivers/uio/uio_dfl.c
> > +++ b/drivers/uio/uio_dfl.c
> > @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
> > }
> >
> >  #define FME_FEATURE_ID_ETH_GROUP	0x10
> > +#define FME_FEATURE_ID_OFS_HSSI		0x15
> >
> >  static const struct dfl_device_id uio_dfl_ids[] =3D {
> >  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> > +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> > --
> > 2.26.2

