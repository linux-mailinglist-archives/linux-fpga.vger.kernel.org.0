Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16AC4F755C
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Apr 2022 07:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiDGFdl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Apr 2022 01:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237941AbiDGFdk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Apr 2022 01:33:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D2193E6;
        Wed,  6 Apr 2022 22:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZxEDpnOUeE2DmL/YVlclkslqmb1vJChZrDAfgvE5nRfvfKHzvuZcGOVO8or6WY/9oU3M3mbj0WxuBOwtR60os+1BYc4qIRHjzg6R5n7Ub3j1XrUeMlRfyxM0auluj5PeSQ4vbGfyd+jxThaOOj9Yy2Ha2y2htcdUkB7rOzFCZJ+6Uoq5brDoCncmGviqLhF2HMJK8uJWtbdOZ+vPwOBvjmrIi1nY7KdAXqZdjXUrvYEg/x2tR57WLj1tTb4EH5UHYoaZ1cLwK4jPGH6Di+OMAqVlJJWYd11wUV5NNb0ilHDm46XSIXVpdmlC+dQGTNXjoY2iXUujgxggtS2C4fSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAzCIFqpmvoWnYSeyOGTWPeTQpI9L9SxSdJfS6n0Ujc=;
 b=XQd8pJXu4pqmRG2iYLAU2UgEZuu14OrO2+u2n0oGgik05IPn2I9D/qPcZBayneYovUxYEIaGbmNzkJfUUkma7YqlLKHfhIbv0FRB32A99Ay4mmpXlO7pvJ7tHJLaEbDOe40c8BhsAUpCwPBCN+8fiUeBR3rfJxZbw5or6ykM08Rzw/c59fEtOqkRfVFr+AmEq2e85LnePL6qxCwe4WP5saFuCTyUHDdja3anK8bPkAwePPOVXUoNMYkoSDqaxne0wjtsMDIQTkzgs0CvAg9OIUJKz9PxUehtLnNmX0M5N4juEOTFXknNb7Lx/Odjaf8NfACtRU/FmJhzdccsZ2iA2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAzCIFqpmvoWnYSeyOGTWPeTQpI9L9SxSdJfS6n0Ujc=;
 b=hhhEMmd1jivgmxE8/rIZH2pbZijNkos/5vKW5FCYE0Nkt/SxuXtShw95FJMQFchLxWcQrnN2pjzqQEzm1jzN+93t/N9VVzP9EGhbblYv9AHk1TGyw7Z9uDAljkh1ftGO4WcW2NtM0R2o0KA1OMi7cOYe0nA3cQanyUn+WK//Pn8=
Received: from SN6PR02MB4576.namprd02.prod.outlook.com (2603:10b6:805:af::17)
 by SN6PR02MB4557.namprd02.prod.outlook.com (2603:10b6:805:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 05:31:39 +0000
Received: from SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::8dc7:8ae9:d26f:a921]) by SN6PR02MB4576.namprd02.prod.outlook.com
 ([fe80::8dc7:8ae9:d26f:a921%3]) with mapi id 15.20.5144.021; Thu, 7 Apr 2022
 05:31:39 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
 description
Thread-Topic: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
 description
Thread-Index: AQHYRxoVV1CPxH/KxES9by+5mseA16zgz8yAgAMiTjA=
Date:   Thu, 7 Apr 2022 05:31:39 +0000
Message-ID: <SN6PR02MB45766BEFCA6532873271099FC2E69@SN6PR02MB4576.namprd02.prod.outlook.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
 <20220403051641.3867610-6-nava.manne@xilinx.com>
 <20220405053547.GA249845@yilunxu-OptiPlex-7050>
In-Reply-To: <20220405053547.GA249845@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8182712d-e087-4dde-ad6e-08da1857e3f9
x-ms-traffictypediagnostic: SN6PR02MB4557:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB45575A611E500A852382CB5FC2E69@SN6PR02MB4557.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Joqz/O7GqHzI1yQJYx2BZWLEBHPZmfNWZkCCK7I+WFvyT2S5b8wpeIUwsN591+flvIsHjYWDi8HpDfiw2sdtywGlcLcbxXSNd9gtH7kBlowMMFiOeYo00CBVyJYmAjVTkCkmp/l0pdYCmzfRiHpPyhOllQj0TW/iGjPjygO1B7V8QwOmOV6cHqdrVLoaXXfUaa867XqN81qeX+pmPk1q+yJ3XbM1uL3OFUQfVLC710i+MVMePA7O9acOohIB19Ec7ltCByWDNnSI1xRL+X4bykGExwu+JUkKbmuwuapIymCI6PsF8sQzVwF+a5qmlD060jQcdcD5QBxbf8BT3yMqHAqUEb59zVhEiS3RtEzrVeRmvHHO1R36ysm0DtfVoePd0nWQKJ6BRcquwWtAyr/KXCUBrGIXaOifhE2waUri49YCiDhTS5OCLcSCTHo4gtd+hbWxdX5tMGsaF+UZSiVQrDuoaTiq1rw/QJ86ya0hqR3yxXZrQJgmuFGsGZ9ztbGrPPlLvZ8fxyvz/RylYNy8iMfERrT6J3bFtpzjEfgxESOvcEJai1f2SSQZF3PuaP69LDd41bkB4m6pNm6eLCXUAqcw7gSIktWOk0T7Y24IMPmVCypIkJaExjJe3AU2M3TthwpRzLhVksw9CHcvzWtFwGbYoRiulpAn58a4/CEIaTeKdfpxs+YZjW6qcRvcACGIfz9HJ4yjYJzQ4tfWP3Jr8Lm++mz5KwXRjyTmBevovFHnjeaj6U8v0i1lH911mFk0uTXqzej6aYckMrX5kofUtPXgZuJZhoZVBeA585+GqFc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4576.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(54906003)(71200400001)(6916009)(316002)(122000001)(38070700005)(9686003)(7696005)(508600001)(33656002)(53546011)(5660300002)(83380400001)(66556008)(55016003)(186003)(26005)(8936002)(107886003)(86362001)(76116006)(2906002)(66946007)(8676002)(64756008)(66446008)(38100700002)(66476007)(52536014)(4326008)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G62MQ0dvjQOW5xVt+bXQwnFl3MynHcfe2PrCzSJPWN+2HKTZdHdvVGYMyFHj?=
 =?us-ascii?Q?iJvE17s7Hmd9VMvg1UsCiuE8GlDezNhCCXr4yCKSWkpXEZHdblRHk+tfTLDT?=
 =?us-ascii?Q?lnvUc2PN0F8HlmcYUbHV0ffmCSh4kWaXGcd3YP/YxBOFhi3k+eJ+wGFyk5pL?=
 =?us-ascii?Q?wY4Wb2vH0EsMEQjBA09OAdK1RVV1IzqqP8D7OEwWT1j0DzxExHyqqmVDiTAQ?=
 =?us-ascii?Q?aNCYkfOyNHSXY3a0vfuardtS9ZqLYmIAwHBNFAFYmLmISE8i7jq+4vCodL05?=
 =?us-ascii?Q?YqXM7u2i28IV+4vE4AsGcZeKH1+Xi2JKH+AXfq+487wQMhCfYzdj40JI7y6a?=
 =?us-ascii?Q?xEcazUEgPknjHzJk1GEr2Pxn9/p2oogjx3MyBkVlWgWQrbZ2VyUIcsB3ULb6?=
 =?us-ascii?Q?ZFqSQu3il/DafyIxxBJWtOlSp4WCUR2jJfHPsHbRkne/uIGo8V2fev40Kf0p?=
 =?us-ascii?Q?s2MDSqwAdLIEmPfuvp/Ia+mRBWWMsw5bMsjrGjr488fqWVB9z0fqrgoXgAAt?=
 =?us-ascii?Q?5xKMXa4e9nhiws0MkZQ2g+Cic5/vwcxdUcTGylFmgjphBd+ewSYYOuaE/1iE?=
 =?us-ascii?Q?bfo0AQqYubCjZV4w2cJgqUAN99ET+JYXaGjC1I638lbK5gTPQE8RBYrFmNFE?=
 =?us-ascii?Q?H0NHDv9JLbnNTnS91jM7sA9YeRd6KIkCUs/a27dRayIUemG9fO1B8SbbwqXu?=
 =?us-ascii?Q?y/w2ofhAry/fouDElL+IfXugoxre9tih7SRvPxWFx+VOjcCRwGV6eznn53Ox?=
 =?us-ascii?Q?qQ55fgpZ5avBkzsuvcgxDKeFN6B+AGL/DCeEt8AjwcK4C9IZ0u2BrF8O5Y8S?=
 =?us-ascii?Q?/QXH3HAMFELiRQR1aP0kfrYNgCHiZiivF2PsaxiVkK0+CabOgovWg7XBvHyl?=
 =?us-ascii?Q?VdwEve/XpGnK1mAtskM59ft8hmIfkkUNA1RAzEwPRkS3MvWZB+wiZXvlWPas?=
 =?us-ascii?Q?wa4OKx6+zHkv3UqjDaJ69WHWA1J4C5H6GAhpH1ZB3X44P84k/dKu0VBKlo5Z?=
 =?us-ascii?Q?SGUHaX7nQWwVNRllygclXJ5Uj5NLQKLqjDHhkWS7zt0joOlip7xG83036TyQ?=
 =?us-ascii?Q?KMtwrOKNxLH2Uk227ri23m3ZMqNBlHbdmdVUmUwYD4paVGveAOM7SP4yaLXD?=
 =?us-ascii?Q?zGDTBVSb3j9rMh+tE6oBqjrKcijpfxz+p/s3wJzswMh3OOGc5R7EjFfwiAT9?=
 =?us-ascii?Q?PVwWf8ZxqTUD0lnPue6YHx5JcrhV1ba+9L+SjRO/kPt62BuF6+mGpJ/nCgLQ?=
 =?us-ascii?Q?qy2Hd5zySlQ11h3gI2yFnTC9M2tgsTeEQET+E3yjF5QWxUuZoYXxYjnBf5SS?=
 =?us-ascii?Q?In0v1Dqsu3OfqhXBGg7F59lFJdkPz70X395P0ED9iCrr6EXBnu39sYIAxpjN?=
 =?us-ascii?Q?1JbpBHhEYgoxvH+nNfo4MZo7KdqAJ3lBWxfiy5bxbNqeGR5uzrIjA1tgD9MD?=
 =?us-ascii?Q?WbWHW9dZr8Fh3M8k3SQ6PCCKbO5pwqtZRcNbwMJs6GHVduO8JnZjL57eQTDO?=
 =?us-ascii?Q?bDF39K80Vcqrwf3cu/uucGdMTck8i4qQhFTtsb+itH36RZO9IQVhSWf4vhtC?=
 =?us-ascii?Q?kJtkE56dawsLlgpzgiX6PM4ORujLZ92NQFZ5D4T74gV8PaKwEv3WkOxYY3ZH?=
 =?us-ascii?Q?y4yZVOYQKxd1FUVWB7kLepMMFEFD8pXTVzz/0kVvSePQhDRGjZw5s2N8D5RW?=
 =?us-ascii?Q?099ZfWlmBhodpgAboMS6VnoxRpi96LUkM6NUFke3LY7ylPnGJ6rrFGYkYOjR?=
 =?us-ascii?Q?rc6U3Tp6fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4576.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8182712d-e087-4dde-ad6e-08da1857e3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 05:31:39.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWGqx8fDO0lCBHZ/j7+O70PZeTGcLOskBeTg1t1OW0vo09kLnAYjsLQYKi5jq5XM2RntG7CTRberFogw6QehnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Xu Yilun <yilun.xu@intel.com>
> Sent: Tuesday, April 5, 2022 11:06 AM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: mdf@kernel.org; hao.wu@intel.com; trix@redhat.com; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
> description
>=20
> On Sun, Apr 03, 2022 at 10:46:41AM +0530, Nava kishore Manne wrote:
> > Fixed the warnings: No description found for return value of 'xxx'
>=20
> The commit message is not clear. There are descriptions for some function=
s,
> but not in right format.
>=20
I agree for some functions has description but not in the right format.
The "Description Not exits" and  "Description not in the right format" in b=
oth cases the tool will report the same warning ie; " warnings: No descript=
ion found for return value of 'xxx'"
This patch address the above warning. So to make it relevant I have added t=
he same in the commit msg.

Regards,
Navakishore.
