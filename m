Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795C53C20F2
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 10:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhGIIoX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 04:44:23 -0400
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:48481
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231582AbhGIIoW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Jul 2021 04:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFJa5VPS2IiSR59y0WLolPS0xb667ZtAptHdcpJymzmkEeNXTCqtgGRN/efVmQUaltGtDgKQKsayoYpx/isR5dlrUlla/zN4+14dUP0HQ/wAtp3QD6PosimQ2UF7W5u9sttTTvK0o6RryPMVrsvGa2ofPx9PYVzC9TXcc8LIROWlUnUBRVjOzhIC4gD+91YVPfkNPlDZp+4suTAkzuTHPI2TDcmD7iMw4uxheseimsG78AcuJxPQ7HTdqsrYsWjnyNJIsM9CirHgNisfSMN3Yl/xuckDsmPV2uxPQd9ZBm3LS7CjBpkuVHF3ae7V/hMZ1BP+3d6gsx0/bL5nFImrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BL0Zer3Isvv20RUZy2TA+M0wTsl8ym+Y4RF0ywp6ic=;
 b=aOzr41y3KBw9o9wzTczC5rQlMT3pMI60SkjI8KSJzDSwGY5otD9ta5lA+PKiYyCPD82WXtB1oOwjp0mLdleq4St9xRrjSCgghvjvzuCjbn+OHbiUJyMIgE+8VbjhnYNKD5RJL/Tznlaw/FWYHBjnQ+o4/EIFaqSZLndxfheBTPSXnvL7g4Wo/LExAnM5d7e90A4zuRl5tO4BKtO1DGVndNccoCtFf5TvOTfGxC1cFkNx9rUpoU+FkcG17Bigkkm/dZpeu3DtR3N1DrSuU8dN3Rfsf2MaEnV1uDTQhxcIaXeFvQVpsqbQLR6binjwi1hEILy/oxGR9ZJwn6kDAyh6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BL0Zer3Isvv20RUZy2TA+M0wTsl8ym+Y4RF0ywp6ic=;
 b=bgrWHXZAvK9FMdYgLYvSUBGAtz9LvaWVomdy/90wP1JkKHnQxqyZ5APXgJY+A3YQtQc07TSJTGVzc8NloP2iTreMjGC5KyMN70IZFV8tkvrJ93+RuCJcNxIejbEd4wLN6XPUz1WFWRHFFsqNTKSvvDO+2zcR7tG08h1qYfU40kg=
Received: from PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) by
 PH0PR02MB8583.namprd02.prod.outlook.com (2603:10b6:510:107::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Fri, 9 Jul 2021 08:41:36 +0000
Received: from PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e]) by PH0PR02MB7336.namprd02.prod.outlook.com
 ([fe80::a8bd:e49f:7daf:fb1e%9]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:41:36 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Rajan Vaja <RAJANV@xilinx.com>,
        Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>,
        Tejas Patel <tejasp@xlnx.xilinx.com>,
        "zou_wei@huawei.com" <zou_wei@huawei.com>,
        Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Ravi Patel <ravipate@xlnx.xilinx.com>,
        "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: RE: [RFC v2 1/4] drivers: firmware: Add user encrypted key load API
 support
Thread-Topic: [RFC v2 1/4] drivers: firmware: Add user encrypted key load API
 support
Thread-Index: AQHXXPOwkA5yuq5AZUmrKpOBPVz+/KsLcSuAgC8PpRA=
Date:   Fri, 9 Jul 2021 08:41:35 +0000
Message-ID: <PH0PR02MB7336410E513B4D026BB4983EC2189@PH0PR02MB7336.namprd02.prod.outlook.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
 <20210609055232.4501-2-nava.manne@xilinx.com> <YMCP/+uYMun478Z9@kroah.com>
In-Reply-To: <YMCP/+uYMun478Z9@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a398dbb9-879c-4bb7-49a5-08d942b55c9f
x-ms-traffictypediagnostic: PH0PR02MB8583:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR02MB858332BF3C21E6FF7406E872C2189@PH0PR02MB8583.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMX668LiZyKdmxCYRorBXqKVSZMD5X9+Q94sbH5y4mqvyR3BxBSA1oqsjNmoA4P5qcJ/QG6/pvR08VxDqImRrNDmcAwe2YqJjLkEcAh2xqXJ9g3iBkYluTrXpfoaVW7A99L+bn4gy88NTK/EU6UH9+uAt9DwcJ1i4GYJ42njLNCWh8+9V4q9fpOYh4RPMsZb6enkDGvGKKTK69Ut8BboWyA6kNdNRDOEk94NvjOMTc4iKyZCZ2lXqPLtMh/btqbzbPn4vaFSYqrHgnBog0XWg7DxsEt7/CqYiIXpmE8r9x9z0csvRDawJ2QjmK3JjKnBViLgkXJIw49U7tThasGDPl1v6Sr1/6PyTfZ0bfViHkmLewVcUslrT9EOMOkM4pf1Y4E0BlKgFQ8WOLZNIO3Rddr83wdkU0EwyjPHkbZJC1QTSwaoz3NKnaLUIuFd59g3gACBkMWKMoiU9m+6cB6XNcmtIChIpGVWqK4V2KL0JzHR7kj/xWxUIAwUTHQSap69qhc0O60Krn3c4li9TH83vWyWeSQJZmbwZAXUmzyVctgb0LuWcKbj/gBaPmBFbiiePjpQ4RGZfNpeBTUXKX1g7bKUAQNQO6Wg/MFM/G8SA+OpxzB9sICVZWu3r2NcV94OI6b7ZF1iK7oHanfleC5fYLzJ7H5Ht4XFcsh1ekhaJgpmMbSQxvxYK974OWfhpBBtlPdJ9i7JXHxbkTFN5JG6ZKbkdnCNIjfHtRdl9vZnOBc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR02MB7336.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(66946007)(8676002)(66476007)(26005)(9686003)(66556008)(7696005)(76116006)(5660300002)(478600001)(966005)(71200400001)(55016002)(83380400001)(55236004)(86362001)(8936002)(64756008)(66446008)(7416002)(122000001)(6916009)(54906003)(186003)(38100700002)(6506007)(33656002)(316002)(53546011)(2906002)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nu1DpCMn4OediWoZx65QsSoL4K8GN4NHVn3GL2TaJweG4qPF8ElJ4O9W8luS?=
 =?us-ascii?Q?F1XhpyiEWLzL2QWYjzS5H1qA+Hq+wgMhCDGXuoiGUTTsU10eWpxkypq1oQ5h?=
 =?us-ascii?Q?4GFjcuCVNfktNjUF/vbAsgpCx/TuJ09ae5ozyspAqIYYcuVwgUxFb5yFrMSV?=
 =?us-ascii?Q?6fiVF5jjRl+W3wUufGcNscxXG+mXSqH5XWB6NeLJSF4pm3iBHMV6DjXdKexk?=
 =?us-ascii?Q?66Dl7y7VSDSAoISd/DdkiZQ5FkYcXwFiQwK49yRyGQd0BNmIfvzWBKqLIQ6R?=
 =?us-ascii?Q?hSNdmk6EW1qdBqRx2xebI/QPvPlctzm5C7Z7li0P86IWTe3KuQuCQRzkr0AX?=
 =?us-ascii?Q?CUtQjVBxZq6CDdq5YPGIM/rHovM1ydTEeaAmfrV8qZAkNxJSkCzDhBPI4i2K?=
 =?us-ascii?Q?QXSHV96t2mc48hrMTK3m1ksoVJC22JYmHi6DrVfvC7zK3qBSYCQs6weV2TpN?=
 =?us-ascii?Q?tqYbx4HZyz5qBN70ejlkyoxyhl7Ew79w9xGlEJ1lLUQogk9pS9HDlL8uYGSZ?=
 =?us-ascii?Q?Y/Q1GDsyyGOdadeNA2N8WRu4gyBOafCsAqYwPnLfRJ7tRSycnwgzV61B3Te8?=
 =?us-ascii?Q?V5AKKhZFP+ZPioKtrC6mA0s0wZ1NHuaALuH/AuO7rxUKVsvZ2EhXZRdNUrg9?=
 =?us-ascii?Q?ny2NTFQ1PobiGPHsCMSOpp1R+w6wLbMPastRZljwuH9/xj+C2hjmwvrw4uD6?=
 =?us-ascii?Q?v7ZZ2Q0o4/fxw0J4tZTjtcgHMj/413/LHmKYol45a1O3Ww3unXaAvcIlInnA?=
 =?us-ascii?Q?QIQG+fnRYznhdRNorSdM+8a00hKSetEnVlOVrq3AfKx9eZzuN/FNaaW6n5K2?=
 =?us-ascii?Q?XuUy4YyCx+LayHG4r557qxYSAlnTmcjqa7cxA3oRK2mEP4z1W9TaGoJH/7U9?=
 =?us-ascii?Q?cAcsiJ6mzWkSTMdLebwvrjyL8QOF+26oXkEq3dfClS4LZ8wjRZg0uBcXN9gs?=
 =?us-ascii?Q?3Sz46Je8tywmAoiN6wruqwxL7Nr4F/uZwwctsJq6xKIljlFE+KzMftZHNh8E?=
 =?us-ascii?Q?6P5ZgJDewgOcDnaepvAdVrs5d3VuLkaW6l2be2+QUfdFIl+g7NTTxta6syls?=
 =?us-ascii?Q?ROTBT2jjvoei+VM7vwdsCc+2kUbXg1IPOx8Fb//ur6BKG7BQNSZ2N1uP//Xi?=
 =?us-ascii?Q?DAOCJRprKj/wIsSdnrkvOG7gRxmu5RV9EimvaK20X98H3H7QNcvcM/sXI57R?=
 =?us-ascii?Q?ddnwoOU2eAvCQbH0cKUhHr+sOUUkt6JI7SHSqQt2IBtxmGKumMcqA5dEhRHR?=
 =?us-ascii?Q?lPpn+VStvAOD7TnLlxYlRHPNkZPbcDLbULWQhc+MTVFLdFEy+PXqwpKw4NTd?=
 =?us-ascii?Q?acu3GpwRJ0RIQ6eb+y3YjOmL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7336.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a398dbb9-879c-4bb7-49a5-08d942b55c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:41:35.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjBquLAAEuInkPDfD3QHLKYKSN4g2h3b8RJmZdOhaUlRPVo3+JA86wJzRiyT2Dr4G6klnd5uIDN2zdlkP1bvhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8583
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

	Thanks for providing the review comments.
Please find my response inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, June 9, 2021 3:25 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: robh+dt@kernel.org; Michal Simek <michals@xilinx.com>;
> mdf@kernel.org; trix@redhat.com; arnd@arndb.de; Rajan Vaja
> <RAJANV@xilinx.com>; Amit Sunil Dhamne <amitsuni@xlnx.xilinx.com>;
> Tejas Patel <tejasp@xlnx.xilinx.com>; zou_wei@huawei.com; Sai Krishna
> Potthuri <lakshmis@xilinx.com>; Ravi Patel <RAVIPATE@xilinx.com>;
> iwamatsu@nigauri.org; Jiaying Liang <jliang@xilinx.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-fpga@vger.kernel.org; git <git@xilinx.com>;
> chinnikishore369@gmail.com
> Subject: Re: [RFC v2 1/4] drivers: firmware: Add user encrypted key load =
API
> support
>=20
> On Wed, Jun 09, 2021 at 11:22:29AM +0530, Nava kishore Manne wrote:
> > This patch adds user encrypted key load API to support User key
> > encrypted images loading use cases from Linux.
>=20
> What is "user key encrypted images"?  Do we need more documentation
> here for what this is and how to use it?
>=20

Xilinx bitstream writer, using AES, encrypts the bitstream. This feature al=
lows user to encrypt bitstream using 256-bit AES encryption in cipher block=
 chaining (CBC) mode.
User can supply a 128-bit Initial Vector and 256-bit key(user key).
For more info please refer here:=20
https://www.xilinx.com/support/documentation/application_notes/xapp1239-fpg=
a-bitstream-encryption.pdf=20

> And why is "User" capitalized?
>=20

Will fix.

Regards,
Navakishore.
