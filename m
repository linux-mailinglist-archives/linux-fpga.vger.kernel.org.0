Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB50504E9B
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Apr 2022 11:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiDRJ5T (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Apr 2022 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiDRJ5R (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Apr 2022 05:57:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51661167C8;
        Mon, 18 Apr 2022 02:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccGdw7RA0SrhPILqlpcUQYeKuO8qvAothB/w0Y9+XDkyWo1RZcn7Vkq3A+vR65wBoM657fj4yLDoFz145OeOdhe8FfuJ62OQXL3xKwT8QNzNAb5ev124YhZGLHyVQRg0fr3jy8pVSlaI/+AHUgsFKglvOo/TGBYkrTEXTmKF6hudXixLG9/5LwsmQMeMQUOeQ9LN43R8T3jCeGGVo3PemJG24w78oVXnJUUF0XIXvHRoBPZcp4ECFUvGB5wbPpdx7ZiJG5AU6BTkvjsRZ5XGLDGTHIe6WuVti2INqwdDO8qNnIefS54JO4K7vCwMN3qpMmMknWv8SYDmGO5Sj/08nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJIRuNbMdTHOAX8229IYLv3xXOXhNvnnb0yTbZ5yTaA=;
 b=eyAv0x4KnKs0nmnw9zCe1g0w/7xb+gQKJbHJA5VM1hW8lVmnSlTBGcRLYEMzphah8Q6TCMRpl6U5jch+10TrSCuAydesJdzV6yEFq4meyv6WMxbSZ73Nr6zUqLbVi6yI99b9ncghzf1Yx88w7endW4Pk38623HPCINh9lmRezESlfSqakZ9QWtcH6lzOYInDkJ0OoV00Jc3aCzz0bfsQ9slpZ376vt20yvQVkOvSZFR5/aSeui71cwJY7guY6vXsd8jAUaSZLLFViEjZOgaRzRy+FX1eKDNnS0FyB7+KlOs22/24mWl+XeOMu111JJ64dFI0/M0RMs2YNYSev/dDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJIRuNbMdTHOAX8229IYLv3xXOXhNvnnb0yTbZ5yTaA=;
 b=d4tqlYNriz6lqSFnw6lnO8xpkCyYzkPhIugYmAsm035KJxOeNUc2MhOA+rYGRy3Oo3/wLQjgi/vH+Y1Vi+4NVsxG46p8xu/DQljGMYfpCWWr0/yXkgqhZhLs3ca3gWKVg9bqtfErQyvcijXj2+AWWE2rqgnrBIh0kVw2H0Ym9Xg=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 09:54:36 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::f1c0:bdc3:9a56:d6d0%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 09:54:35 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Joe Perches <joe@perches.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v4 2/5] fpga: fix for coding style issues
Thread-Topic: [PATCH v4 2/5] fpga: fix for coding style issues
Thread-Index: AQHYUZcjkgksvVyG0kSyIxbadyFg96zyw0MAgAKsDPA=
Date:   Mon, 18 Apr 2022 09:54:35 +0000
Message-ID: <SN6PR02MB45763D1B949353F99AAFE7D8C2F39@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
         <20220416133719.3382895-3-nava.manne@xilinx.com>
 <ac22068dad06fd61f2e82c0bf7c0f58a4e5df050.camel@perches.com>
In-Reply-To: <ac22068dad06fd61f2e82c0bf7c0f58a4e5df050.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0e76d32-3b75-4b19-dc33-08da212171f8
x-ms-traffictypediagnostic: BYAPR02MB5559:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB5559A29ECB9FED0AB21C2AA8C2F39@BYAPR02MB5559.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzSdKmKKu0OEjbGpnE2UbgSMnc9f935R3Xjfl0SVy5i9nkB2bV8K0sABx2N2RauUmEmF3eagR2FzxSEzcUa7PN2pq7TWtNJiK5X/BRJokTwbOBlBwxggb5l9sPGGCh7sFPSK9rs5Cw3VgwnKWIhcbCulN4fgyfl6WhsIJZo7Sh38oV9JByGeUoM+mkz9jH8jM7UIA8eJUUDv14z2EoBPsI2dzweLbKCz7n/360m+e2rCburLhnwTfb5xafs6pf+I3Xwn76pVybUClAQMUVn0+Wts4A4H0Fk1nEPe71pMIaZ0s4YuAiXdGcDFuT4Mj2zaPZyHXr3X7eILr9Br1Gbl1peUKTyS3qY00eB7/XMp6raUtL+XeFDpgSjFuYK27Ml/JdReUU1nMhjY/GPHpR0df6MFO2C3jflAl00eG1I2ah75c6K+GoIWZ7LDYxOOmFnOUHIPq3qWAZASRZwFCNl0xJ5Y+YqHPdZdBlCITvbusmvtjsAnMi1mkt1qPOhv876lDuCKqROakQ+GRquMXaSeyhIMUCb91+dpWtec+i3gbi4yrpgSVdNoG2qZrPohznby6Shc1Lbm+Cxm0ffsT1SUFOl38ZTKFHUeM2FU6m/fSFk9fyc4tUpnxZW2ANbvjJYSG9i3PFpXy7dae+mNyuCu3jnmnpi/ITdOKyvwd7RcAbJOaWvlArjx6HMxeut59sj2QckX0xV7feIAG0pKM7p+smZ8n0ct6+K3bvMoqw36EdY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(64756008)(66476007)(66446008)(33656002)(66556008)(66946007)(4744005)(52536014)(8936002)(76116006)(83380400001)(5660300002)(55016003)(8676002)(26005)(110136005)(186003)(921005)(508600001)(316002)(6636002)(2906002)(38100700002)(86362001)(38070700005)(71200400001)(9686003)(53546011)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?raLm+WgCEuFlQWnRDFMludNdhTsWTQZkZtp1IMWzEFOQ7m76+kOmVRQ1j2lD?=
 =?us-ascii?Q?FJBsZqdAPS4yQY7HVudUNqojcEZWDl7u5j5R6T7fg9kbe/OLRb2gsDFQXFyP?=
 =?us-ascii?Q?q2uIf/ZCaRMzdOhV+Ic/G+PeTC/zCs5ANfMx1AdoJNqM6+ZWsrfmosMNQisw?=
 =?us-ascii?Q?DO7eVkUGWpKTQbCaIFrYrZ65/VWgWO6EYEro048o9eK1DQm+a30CYqYDIYPd?=
 =?us-ascii?Q?6kjTgxqCKbPNh/xPp18k+6OV7/xYpdM25xb6A61CNoXm2+hHWx7hI9taAriA?=
 =?us-ascii?Q?fn+JNldv0GSv03pAa1IwT/+5gEP38sE8htQypAfeBO8TNtIaF/gP/Xqe8Lrp?=
 =?us-ascii?Q?CIiaGbL0pStR+RUHZjDHL+5rVU+E01bYo1ypxqp0Aha74MidGYTiBlrM6RO3?=
 =?us-ascii?Q?y6LMFOP6fhGWTKLbx0jlymEy4+FUFIX8SrOuJuK7zqwGQs2LMKHYM1WdH/o1?=
 =?us-ascii?Q?8NuxSXfTCI2TT5yvp2TTi9YzjfhGXnCUZPCzsMTTiZqpdZTNaNqQhnmvt/6M?=
 =?us-ascii?Q?fZ5e3E+Qd9GTvC98dIiBMsQ7W8DN5HODYXhmePz0K8GQezqWrvLMMf/bzR/H?=
 =?us-ascii?Q?s1yvmD7BZBDq6WWPTyQnIQoqRpfZxKuWx6rAII5DNwRuQF+rknCxdJa+a5EP?=
 =?us-ascii?Q?qNVfZZYHigszew+7izyUH959q2fGx6axQ3LUTeEMOw/h6bpijud21edc3TnT?=
 =?us-ascii?Q?kXB0W7joWK0vBOHyuTFSlcz4A86vGcqIHZSQzj6CqBEVmtKqlapxTYVHjBGX?=
 =?us-ascii?Q?UoybqPN8oT7TK3FiubkBqTx77pEp/Kj7xWdiZG1BPY1pPjHp8oLjsYT9ujgO?=
 =?us-ascii?Q?+6uFrZIJdo2g+AEEXrf0O8IIVOeVihqEXj5mWNFmRkfroNiim+YhtAIc8jO7?=
 =?us-ascii?Q?87Fcx1EQRsIphg0wIbfnVWU/uRSSCye/hpMFjEOLQc5QuoR5QgrpeUtDvKek?=
 =?us-ascii?Q?tNUi0tobFO5aMpVc3FSfpf2/e47m0c111mB013QKtn7T6peH3zSKULINRPcw?=
 =?us-ascii?Q?/sBJ9g1Rl/NVoQ8YHjX15HoPVVLoNTKBuCbSbkkYAMTAoKppMHHbBsEOlnIb?=
 =?us-ascii?Q?GRcK7IeJzimEtQ9WQk+ffAZwiHnVMlDy6ZpA/ux72vZ29sLydosAeThaVU3N?=
 =?us-ascii?Q?Htk7t68oqB78zTG+I7OtQp0/eKQHaTcwHZJfwE3ds15KGTkC42uMAYR2yNIQ?=
 =?us-ascii?Q?ovHUGSy1DwM3wjsf4hMapFDrVZmdkFdJf1fmQmcCc/Nv3KF8RZGVzk3O7F3P?=
 =?us-ascii?Q?9XszbKwxMk6olJG6PzXNZkwB0r0f4KA1aHtq+QZ3c5fb9kH0z8pFqthTNpzW?=
 =?us-ascii?Q?PGknpLl87QHcwQyA0jOgiSPQ6vE5wSqukmR/YBT77PG4CDpiTMrQikvd/dyo?=
 =?us-ascii?Q?KVaUGnS+MSo9WdtBFgXd/Lka52cbfBpz/++RhESGEr9eY4ocbJvO3tTEMrOb?=
 =?us-ascii?Q?TpnOyEhRTtsr6Tw48dP3u64QXMSPCzgFdkn8bl0m+FS1dDMaswO4dMG8OIdQ?=
 =?us-ascii?Q?eD27h56/pz+LMWIzA1wXl+0zPjSLg8Pz32DUP2iVOx9Rr6BM/rpAgZFKpfGx?=
 =?us-ascii?Q?o343abu7ZyoWWyb186Cl4eabBDkKvu3JnCTvhuIYbEel7PFGdZXde2Kx8Q6U?=
 =?us-ascii?Q?7fecvBL8ymTc429+k9uieKwNjbaKEbYnPEGR745HfdzNaVSjmcmuK3IPhkUG?=
 =?us-ascii?Q?h6oKqkuvscRQ96DlLUYnwLXx7qnVmSgUZCj4ilnXHu5b8YsCWbZcPYH+Qvkw?=
 =?us-ascii?Q?vTgi32QeyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e76d32-3b75-4b19-dc33-08da212171f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 09:54:35.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1hT5HHn/EqkuI0UKhRT9zqC2fsKwN1lBElR42ycthCIdfwnsXkm5G6nbV1K48+8IsARXFV0duFiOJv8M/N5ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5559
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Joe,

	Please find my response inline.

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Saturday, April 16, 2022 10:29 PM
> To: Nava kishore Manne <navam@xilinx.com>; mdf@kernel.org;
> hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
>=20
> On Sat, 2022-04-16 at 19:07 +0530, Nava kishore Manne wrote:
> > fixes the below checks reported by checkpatch.pl Lines should not end
> > with a '('
> > Alignment should match open parenthesis
>=20
> in fpga-mgr:
> 	Another possibillty would be to change the function arguments
>=20
> and
>=20
> in fpga-region:
> 	Ideally keep the include declaration and definition styles synced
>=20

These changes are targeted to fix the checks reported by checkpatch.pl with=
out touching the actual functionality.

Regards,
Navakishore.
