Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFC32CD6F
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 08:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhCDHPJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 02:15:09 -0500
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:3424
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236109AbhCDHOm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 02:14:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2zdWE7aS5phOU+YLIMOYV9cGIcO9tey8GQOiaxli0B/PdYqiFGs5kImvTZmS4RWLyQ5HMiNSfIGm0IKsnzk1xS08vz9yz/eBPb8Xnvl/IR+0G4uxuJ8JH07OF+jXrTc7G0lylJba8tch1Om7Vp4/vFNozUwDL0AFIN9RxINM2RzxX1aWk5n9w525AZuvnuRB5Sq24WWbbEuJvKqnN1MUsYb0pnqwEkuxZPd+cYrb58iROAHZ2ytf5JxhYdDj+fYjcyvOSuy37FAbPxDtvxIdmSgZKvNF9RRQaz7gehyrOGWKh7+g+V3t9kFnFXHVogZ6jEt90sLFJxR+CVLwaOJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mljoC9d9VmQvUKwMmMusbpz4aUvvt4RdbVq1mMJKBB0=;
 b=Yp5L4ALPdIe0+aLnTFaAVtTaa16YUyyLmnQogAFuHbPsU8430W1XLCRGLv0qMZWZsjMPiMbCaKYcWBDXHlKiJnjU/NgbwH92EyORC6ti+QHAqgDx/ftEixPE4Gg1nCtdpqJB5deY0SFmI0HX4nMNbZ3FoLvmrbYOC0p0hnAz6H/KoPg8O1pOcVw0Qibor0KCLvhD1SW5T6D+MpXxicvPpORjCqaVmOvRoYI4SIUh8C7JHUfWytROdF+8Qw1eS3+llmencYuIwThAWIRB+IcaR07/eYEkmwDlaGBxF4C10RqbfLQBMVSXlw2orWBwJwjwEMKHPboQru4JLymy1R1E4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mljoC9d9VmQvUKwMmMusbpz4aUvvt4RdbVq1mMJKBB0=;
 b=jAB52seF8/vvPiWFiFmfZiFFjZQc5GEuW9mvN2LjAwohQuK9PkBs3u7rsAaIlI6GE+syacR7MXKidQc1PnKT0X6K1vSshPX8CvJh3J7aO+yoFnIqKtivqME6S5aJfihl/S4o7V4DVCPgBVmh5PNpcsrgojB4PEXv1PfBWwdonR8=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (2603:10b6:300:44::9)
 by MWHPR02MB2317.namprd02.prod.outlook.com (2603:10b6:300:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 4 Mar
 2021 07:13:48 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::297d:1fb:ad07:1b26%9]) with mapi id 15.20.3912.022; Thu, 4 Mar 2021
 07:13:41 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
CC:     git <git@xilinx.com>
Subject: RE: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for Xilinx
Thread-Topic: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for
 Xilinx
Thread-Index: AQHXADVYKfdNXFvF5k+nT8eyko1p1qpzi0vA
Date:   Thu, 4 Mar 2021 07:13:41 +0000
Message-ID: <MWHPR02MB2623DA5CC0F45345C6EC7F9CC2979@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20210211051148.16722-1-nava.manne@xilinx.com>
In-Reply-To: <20210211051148.16722-1-nava.manne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 561b201b-ac8e-4128-d266-08d8dedd0a6b
x-ms-traffictypediagnostic: MWHPR02MB2317:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR02MB2317963BB00BF7D422DAB8EEC2979@MWHPR02MB2317.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijyHZ7iYCvp8JRWgVuFo87DszrU7ErarF+ir6GB2CUgXWv559SgPvrpgcbbS8ikOf0xZcMNU/b1sDrX0x2pgEW+GeFaazu6I41ez7dc4l8JvX2hqdOel2uMnjMYgnwWVvwwbwNIp5EcofKLlYEc3eJ35ShMsfaFxYs+iGfZS8q+ERW00KXopcwH/RZ8PV4tWgTqY/7C0oJqEmDHH/YJzY8pY43AeiKi3NRYeAi1Qvb+OsZh2DSOigFutUDhdqk2Dl/IeqlcUNu0U5nGHifmG1RjdUtHXxvsMGujFllszYYdIA1gOvmesAXxpjVpsKh1+NBMKJBkdKZgiabS9JpIzFfhwP2/43sIJ6Qa0TUjMJGf8AH3yeSDFdCsrKBlQkItoCPj5myq3sEP60tALH3qCIXIElnPlCyQSQSPJBd+4A2ejM1jsfWsbXLJEWM+0Jqmdn+kCFHdoYCHZQodVWoEtI8c6jbhKwknn3a7y7ItT6mNJMaymnfHXp6gvPGzm9388SgFduAzd+cHDTkglBKndQSUYxZzLc2Cl7FEb2aTO+wN1/uB9un8II7iXoFwoyu/V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR02MB2623.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(921005)(71200400001)(2906002)(9686003)(66946007)(66476007)(86362001)(107886003)(8676002)(55016002)(33656002)(5660300002)(4326008)(76116006)(66446008)(66556008)(8936002)(52536014)(316002)(53546011)(83380400001)(110136005)(64756008)(478600001)(186003)(6506007)(4744005)(26005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BXRoPzNqyX7HTD6nMDHw1d5+9VSlAXq5y5RC1DVCPigpkAj2FU67IMG0lMxj?=
 =?us-ascii?Q?x/ZhXyQSTuvjuakI8zXBYaIRMJeVl+QFrmD5PSXQe5yfbCGzUe9xI1NKagkw?=
 =?us-ascii?Q?UHnV6Kd/HDRub5bXWiT+Mn/rNQuF+mR5tv7AtDdY9pBT5QPPuFk7s5A6SFdI?=
 =?us-ascii?Q?KrddqYvJEBaPcLGW/KmwqS7E3QSFQQLSUdH14kDmma7Fj8n2hJ5O/ntYV4nk?=
 =?us-ascii?Q?OrLE4y0rIxyi/yXI7HHfmP9QUp/eEeGOvRVD3i7oo0ZyB1xvgn4NWprR0gBd?=
 =?us-ascii?Q?igDPfjDbmjEbaZji+uSilrmYETB//aCMXEVYVsbnLNIGqbPel/PnLd6HIykR?=
 =?us-ascii?Q?cHC9GaePDb1kwUvXXjD6ns77lhRxyySnRJUyGBHYqYS1+T8DbQUzkgYf+F0s?=
 =?us-ascii?Q?32mpZkydZ8m4ZSwSdOepevsVSLnFgH/Bkcbh5Y+yI38Fs+HJqJxu8aIEBZIP?=
 =?us-ascii?Q?tpAB78t05L+Th3OLGWkYAmCAZBveDjLBCFU0dg6xnkGtMduYQw+hlzizGvAX?=
 =?us-ascii?Q?wS4ed2k2u1YJ0YqpCJM9oHa0OJLa2/niWuqDBA/Y+dw7zbuoqOWJZF0UBeTw?=
 =?us-ascii?Q?UxGzfCFmiiyG1g6gnihkBBAsBqDT4FY04GDFLE/W8os0dtgQ3us0Rd6rLRld?=
 =?us-ascii?Q?4G08cCkLzSuavkUHClveq/zaRydRWsljUyuRbD15+Mk2uz4lLqow+1johIu1?=
 =?us-ascii?Q?xg7A5sXU70YOeg08qdP/SFIzwTvBkABkQEOzXIbUQ8dmce+f95AHZjtUW1s/?=
 =?us-ascii?Q?kbysyua1sizxlJSzXDSOzvDNJhdxkbS4Mq7cn7D8Ds/LNlwWRR+/JcMNhkO+?=
 =?us-ascii?Q?YxxFUJvlX9HZu3YDLeGMyfEBlzmBX6pI7BEWZCNqTuT0YgJ+eo1G9ZH+I/En?=
 =?us-ascii?Q?AqMBRIfofHZ4oLM3CjLdXIs9Gff2C6vHS0xlZEVEK/YGv2DvgR2t3bk1r855?=
 =?us-ascii?Q?bMlk7ei/T6ChWsFcuV9KKlXso8ZdlocFDqmdRkOsTyy6nY/jlv1PxvD5Yhxa?=
 =?us-ascii?Q?Vz36t5lVszK65clGvhfzYF4e40K47f9LQQmqPQpTIiv4tgWjg+elCHh5l7wT?=
 =?us-ascii?Q?NBvt9WjUL9rTIbGS3/HtP35Dx9c8u/SfioT6Mydwu9zw4ubvb90xH2KULx6p?=
 =?us-ascii?Q?iWrvsJVDuqf3T3l2b8hu04LNAEGR3LJqMXiP6VqC+qiqsvZXg+WP0HHTOeHy?=
 =?us-ascii?Q?TLl2yIwCq4enIxO1Z+AJVoJlh3tkquoauHg5Kv6HFrVI7goZCTcnzff5K2uC?=
 =?us-ascii?Q?RF4aChgkMV2ZBvSF3W+tV8WO+jR4XVGywyzV/r5zCyjIFh8UJYAX5YNgUq8G?=
 =?us-ascii?Q?xGPPtdAY8IKXWWA8RYDnfFLw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR02MB2623.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561b201b-ac8e-4128-d266-08d8dedd0a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 07:13:41.5672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVaxJbX5zaOKf1xMRwpdEzJVm3JbmKyp7/wdmAxWkAAjIyt9Zu2WqNc5dLyD6FjrqBR37oyLJ8D/VdEU0L/wsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2317
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Ping!

> -----Original Message-----
> From: Nava kishore Manne <nava.manne@xilinx.com>
> Sent: Thursday, February 11, 2021 10:42 AM
> To: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; chinnikishore369@gmail.com
> Cc: git <git@xilinx.com>; Nava kishore Manne <navam@xilinx.com>
> Subject: [PATCH v2 0/2] Add DFX AXI Shutdown manager IP support for Xilin=
x
>=20
> Nava kishore Manne (2):
>   dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown
>     manager
>   fpga: Add support for Xilinx DFX AXI Shutdown manager
>=20
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 24 +++++++++++-
>  drivers/fpga/Kconfig                          |  9 ++++-
>  drivers/fpga/xilinx-pr-decoupler.c            | 37 ++++++++++++++++---
>  3 files changed, 63 insertions(+), 7 deletions(-)
>=20
> --
> 2.18.0

