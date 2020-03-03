Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213B517823E
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Mar 2020 20:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgCCSP7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Mar 2020 13:15:59 -0500
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:12082 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728356AbgCCSP7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Mar 2020 13:15:59 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 13:15:57 EST
Received: from pps.filterd (m0075030.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023I3BjS048877;
        Tue, 3 Mar 2020 13:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=proofpoint;
 bh=b6PpxzwpHQzvt5EHjjWx8lKyU4V0tA+VBjnoY6OCJ3g=;
 b=vY9QnJSJQ9MYGYp4ShMKMW/KxtiiNeUQDhgyMcNzeygjzfqi60Ionfb/ToHv5LZL4aTJ
 Qjzx32ZqhzmlnCktGhXj8xeoF/r3JsJq+I3Bzfw4FzKB9ykxWOi8QuHoZOz1N98XHclG
 s82wrAaWsUr3SSr9TQg8p2GHmEhv2mXkwZcRrrE6MClmZqKmK5HU7s5dd9FSp8CEYVN3
 W2vwxIQJJbw/QEP3PHI2e1eSSv+i4VQBL2H/wPNXYilz4xZHFABPwaMwoJdcGmgAWfpu
 hsfC1Y0/gBhqU8YPnUnkMzF3P7wj9Menb9CWsp9W76GtvzcQlf/wojxGRVzt1VR4M9Nz Tg== 
Authentication-Results: seagate.com;
        dkim=pass header.s=selector1 header.d=seagate.com;
        dkim=fail header.s=selector1 header.d=seagate.com
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-00003501.pphosted.com with ESMTP id 2yg5vt03q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Mar 2020 13:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6PpxzwpHQzvt5EHjjWx8lKyU4V0tA+VBjnoY6OCJ3g=;
 b=ZUKQNrMETDYehLRMAZCnuEEuwqQRLo9kfEhjEV7EUqCy35+sXWEz4HYJI4ZN85rzln9ZK0s4NC/TaObJ9R2cLmYfDudNN87Lni2yZyjgUFEkp3SOYkojB7GI2pclmykx73gtlXwH8+i/VFqRYE6ioaXtwwdgICa7D63tRySjDE0=
Received: from MW2PR20MB2106.namprd20.prod.outlook.com (2603:10b6:907:4::14)
 by MW2PR20MB2075.namprd20.prod.outlook.com (2603:10b6:907:a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Tue, 3 Mar
 2020 18:07:22 +0000
Received: from MW2PR20MB2106.namprd20.prod.outlook.com
 ([fe80::c983:9197:f341:7e56]) by MW2PR20MB2106.namprd20.prod.outlook.com
 ([fe80::c983:9197:f341:7e56%3]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 18:07:21 +0000
From:   Luis Tanica <luis.f.tanica@seagate.com>
To:     Arnd Bergmann <arnd@arndb.de>, Xu Yilun <yilun.xu@intel.com>
CC:     John Garry <john.garry@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>
Subject: Re: LPC Bus Driver
Thread-Topic: LPC Bus Driver
Thread-Index: AQHV8OEwW1ITeLF/ykCZZuoytr/YL6g2pwoAgABcsgCAAAsCAIAAFlun
Date:   Tue, 3 Mar 2020 18:07:21 +0000
Message-ID: <3992844da4534804ade896dd5ba4dfcbMW2PR20MB2106669451CA09B579ECB973A0E40@MW2PR20MB2106.namprd20.prod.outlook.com>
References: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
 <797cec65-5504-ee85-3fe4-fe2b4c90991f@huawei.com>
 <20200303154522.GA24568@yilunxu-OptiPlex-7050>,<CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
In-Reply-To: <CAK8P3a01vYfqvj4eRQQsqC9FrUTr=q6ZRF-EuYV0iGC7AV7UBQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
received-spf: None (protection.outlook.com: seagate.com does not designate
 permitted sender hosts)
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiXqZs+huBOrjC7iQchWQ/+CzPB72WH42P+EvIjys3M=;
 b=FknK4mdL/M4tOynyMeQ1KyILBNcvoEUUiR1+yVyCe9eymC7pGtG8pmh96qhH+Y2sbXyT2vPGXzolAef+yW/kWKCCdit1cIukWQJZWlblYlJFktAmzaArZY/NwrKa6ZJaexxb/+Wo3ZQo4s6pAQSQmWdk7NcwGti9WdOfkY1voT8=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtrsxCozXIgPwmT4eK4iHz82ykIMH7JchZBgejCL9v6x+mwBf2plfrOcPYukpiOtoNwppt0evLY5da3NvrER7VKGhBtjPY/gNp+rNdGJZNrA5RarvVnK3htYRajIOC+ZjYaygcYdLiwYj2ddjQqoTkbd8BfmZkIerQE4l6cltCoVHOCcU+PtMaktCZbFgwC76QBOFL/71eU0YgO9V5Pt2EeWhFGIAP8Ycxw/GDH9T5GfQbBRwmTxrCdxUtVVndzYYubqqD4wL9muCHd4SF4GUpl9fMBNCCGnXnXrOsG5nbhU4u5qgGxdPOp4AXOpa20ER2fGNMTrx0r/EfSLyVfzQw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiXqZs+huBOrjC7iQchWQ/+CzPB72WH42P+EvIjys3M=;
 b=n8stOdNxVXOcCezscXZkzuH8Rt+HyyIasFv5UMwczCw7UwZEZ9yEZGGDai5D9ixm0cNR+xDw41Sfj5/KqGCZoKK7ZB8VUjhSFEc1gTiHlqFj8FSOLc5yi7GrSxfA7uRr6UqbI2GJP++reUmJ7KVpAfymToW4nehDjEZ/Zg8GHqh/KXuWcrvmr9PHj7CkiRlxBCznnzOSwgxVPxXgvO9UkS1a0nTD4RjxIcUCMHxTvtkZQy3wElALzWQNeEFHT3IWBrA47ZhuKu0BDt8EAD/i9j7biqkFXxrqQ3kjZ2rmmd1atoFOCXEXiokIQBf/IB7zwBZhbgYgffweNVNvtOSoDg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
x-originating-ip: [134.204.222.36]
x-ms-office365-filtering-correlation-id: 4ec6afda-f9da-45b6-c8a8-08d7bf9db84f
x-ms-traffictypediagnostic: MW2PR20MB2060:|MW2PR20MB2075:
x-microsoft-antispam-prvs: <MW2PR20MB2075572BDB1D785A7F193250A0E40@MW2PR20MB2075.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: =?iso-8859-1?Q?SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(34600?=
 =?iso-8859-1?Q?2)(396003)(376002)(199004)(189003)(19627405001)(54906003)(?=
 =?iso-8859-1?Q?33656002)(9686003)(26005)(2906002)(110136005)(7116003)(761?=
 =?iso-8859-1?Q?16006)(66476007)(55016002)(66446008)(66556008)(66946007)(6?=
 =?iso-8859-1?Q?4756008)(91956017)(86362001)(7696005)(186003)(81166006)(89?=
 =?iso-8859-1?Q?36002)(71200400001)(81156014)(53546011)(316002)(52536014)(?=
 =?iso-8859-1?Q?45080400002)(508600001)(3480700007)(8676002)(4326008)(6506?=
 =?iso-8859-1?Q?007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR20MB2060?=
 =?iso-8859-1?Q?;H:MW2PR20MB2106.namprd20.prod.outlook.com;FPR:;SPF:None;L?=
 =?iso-8859-1?Q?ANG:en;PTR:InfoNoRecords;A:1;MX:1;SFV:NSPM;SFS:(10009020)(?=
 =?iso-8859-1?Q?346002)(396003)(366004)(136003)(376002)(39860400002)(19900?=
 =?iso-8859-1?Q?4)(189003)(71200400001)(55016002)(76116006)(7116003)(91956?=
 =?iso-8859-1?Q?017)(2906002)(86362001)(3480700007)(8936002)(5660300002)(6?=
 =?iso-8859-1?Q?506007)(53546011)(110136005)(54906003)(66446008)(64756008)?=
 =?iso-8859-1?Q?(66556008)(7696005)(66946007)(8676002)(186003)(26005)(8116?=
 =?iso-8859-1?Q?6006)(9686003)(66476007)(81156014)(4326008)(316002)(450804?=
 =?iso-8859-1?Q?00002)(508600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR20MB207?=
 =?iso-8859-1?Q?5;H:MW2PR20MB2106.namprd20.prod.outlook.com;FPR:;SPF:None;?=
 =?iso-8859-1?Q?LANG:en;PTR:InfoNoRecords;A:1;MX:1;?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irJ1OQ1vSr9ah74hsFeTcFSIWh6Qz1qWf9eJtZPY0eKDkGKxUBc4WZELt/oWrP6x0D62r7xk59bCJ+rXQJw0hYWD77qU+2cxWWKTyWqJZ/g4Dw7ObV9raAfK25HJrs3l4L1oj//6vh/gebx2m4m8LRvgKELUrHP7u4U2xk+CRO8RebcZhbXGZ1TIEG2ABKja8q5hHIWZIM6+Cr6y0Oqcy3m93T3s+7mX5/6MVsHMz07yOKJV4whomk1UAwp1ZG7XYAbvf/71taaurUMZSnpzOSpZ1YCfx7qjadnwkxwAJs/GpLgCzlzQZpLuTOSKQXhQkS+5qn68bYsb+Ic43bBp0ljyG63YikTZiKM8lpbpqrNV8clUvpJkOif3CTPdaQH1hZgOxwuz8fPt74idtJtT2Qzf7EbpGniIkprIhoS+gxz9T4Ox52d2ahQhNKqTjm6Z
x-ms-exchange-antispam-messagedata: X4eISfOpRbmMM8YqgozrUGGRppygfnfS0s2saMqER/1vFyk9Ehx/C3r5eHajKjhDlBMQk+HlqAcXmFsR9Vs5+QL8mIurIXdviCTMAecQ49KFvCm4bvAQ9o7e+UV0LogyKk9RonGYOhoLtmtAFx3/UA==
x-ms-exchange-transport-forked: True
x-ms-exchange-crosstenant-network-message-id: eeb6cf23-1722-4c99-d6ec-08d7bf9c345e
x-ms-exchange-crosstenant-originalarrivaltime: 03 Mar 2020 17:56:30.9179 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: d466216a-c643-434a-9c2e-057448c17cbe
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: HaDeuShsS5tqXt9QS3lB6VC2XhRq83U3AJi9IANwmqc68GTvywx8LTNL5BUwgwPkNgoSbUnmJDWc+St3TfDGIw/9xglIEh7NGWbbQ2eIexc=
x-ms-exchange-transport-crosstenantheadersstamped: MW2PR20MB2060
x-proofpoint-policyroute: Outbound
x-proofpoint-virus-version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_06:2020-03-03,2020-03-03 signatures=0
x-proofpoint-spam-details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030121
x-proofpoint-spam-policy: Default Domain Policy
x-ms-office365-filtering-correlation-id-prvs: eeb6cf23-1722-4c99-d6ec-08d7bf9c345e
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D3A9BEA3FB70F048B618023D91C9FACF@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec6afda-f9da-45b6-c8a8-08d7bf9db84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 18:07:21.7433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3s8q93ErVTKfFmsONBt+JsFeVItJc68h5xFGQmKPc9bho5/oZcEfZfrNOFpN9ttNRdIUHxNC6XVFkvGIvDkOVDbUA698qmsYmXUgJECTlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR20MB2075
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_06:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030122
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Thank you all for the help. This is the gist of what I got from your respon=
ses.=0A=
=0A=
=A0- if CPLD is the only thing on LPC bus, consider creating a single drive=
r for it=0A=
=A0- if not, then creating the LPC bus layer would be ideal=0A=
=A0- could also consider I2C framework and treat it like an I2C device=0A=
=0A=
I believe for us we'll only ever have that one CPLD on the LPC bus, so a si=
ngle driver could be a good idea.=0A=
The only reason I like regmap though, is that I could define a regmap bus t=
hat would implement all the LPC read/write operations (by implementing the =
.reg_read and .reg_write for regmap_bus) and then I could use those registe=
rs as I pleased from different places.=0A=
For instance, we could have a CPLD driver that exposes all the registers/fi=
elds via sysfs but then I could also have an arm-reset driver that only map=
s the register it needs for the arm reset.=0A=
=0A=
I actually started implementing the LPC bus, and then having 2 devices (res=
et and cpld) implemented as LPC devices.=0A=
Even though it seems a bit more logical overall, it's a lot of overhead for=
 what I need.=0A=
=0A=
I would like to take a look at the I2C option, since that's the only idea h=
ere I haven't explored. If you could point me in the right direction on how=
 to do it (or some examples in the kernel) I'd appreciate.=0A=
I should be able to make a decision after that, but I'm tempted to create a=
 single driver and keep it simple for now.=0A=
=0A=
P.S.: This is my first time using the mailing list and I'm guessing Outlook=
 is not the best client to use. Any tips on that end?=0A=
=0A=
=A0 =A0Luis=0A=
=0A=
=0A=
=0A=
=0A=
From: Arnd Bergmann <arnd@arndb.de>=0A=
=0A=
Sent: Tuesday, March 3, 2020 09:24=0A=
=0A=
To: Xu Yilun <yilun.xu@intel.com>=0A=
=0A=
Cc: John Garry <john.garry@huawei.com>; Luis Tanica <luis.f.tanica@seagate.=
com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-fp=
ga@vger.kernel.org <linux-fpga@vger.kernel.org>; gregkh <gregkh@linuxfounda=
tion.org>=0A=
=0A=
Subject: Re: LPC Bus Driver=0A=
=0A=
=A0=0A=
=0A=
=0A=
On Tue, Mar 3, 2020 at 4:47 PM Xu Yilun <yilun.xu@intel.com> wrote:=0A=
=0A=
> On Tue, Mar 03, 2020 at 10:13:36AM +0000, John Garry wrote:=0A=
=0A=
> > + add fpga list and Greg+Arnd for misc drivers=0A=
=0A=
> > >We have this board with our own SoC, which is connected to an external=
 CPLD (FPGA) via LPC (low pin count) bus.=0A=
=0A=
> > >I've been doing some research to see what the best way of designing th=
e drivers for it would be, and came across the Hisilicon LPC driver stuff (=
which I believe you're the maintainer for).=0A=
=0A=
> > >=0A=
=0A=
> > >Just a little background. Let's say our host (ARM) has a custom LPC co=
ntroller. The LPC controller let's us perform reads/writes of CPLD register=
s via LPC bus. This CPLD is the only slave device attached to that bus and =
we only use it for reading/writing=0A=
 certain=0A=
=0A=
> > >=A0 registers (e.g., we use it to access some system information and f=
or resetting the ARM during reboot).=0A=
=0A=
> > >=0A=
=0A=
> > >I was looking at the regmap framework and that seemed a good way to go=
.=0A=
=0A=
> >=0A=
=0A=
> > I thought that regmap only allows mapping in MMIO regions for multiplex=
ing=0A=
=0A=
> > access from multiple drivers or accessing registers outside the device =
HW=0A=
=0A=
> > registers, but you seem to need to manually generate the LPC bus access=
es to=0A=
=0A=
> > access registers on the slave device.=0A=
=0A=
>=0A=
=0A=
> I'm not familar with LPC controller, but seems it could not perform=0A=
=0A=
> read/write by one memory access or io access instruction=0A=
=0A=
>=0A=
=0A=
> I didn't find an existing bus_type for LPC bus, so I think regmap is a=0A=
=0A=
> good way. When you have implemented the regmap for LPC bus, you need to=
=0A=
=0A=
> access the CPLD registers by regmap_read/write, and just pass CPLD local=
=0A=
=0A=
> register addr as parameter.=0A=
=0A=
=0A=
=0A=
LPC uses the same software abstraction as the old ISA bus, providing=0A=
=0A=
port (inb/outb) and mmio (readl/writel) style register access as well as=0A=
=0A=
interrupts and a crude form of DMA access.=0A=
=0A=
=0A=
=0A=
Whether regmap or something else works depends on which of these=0A=
=0A=
communication options the CPLD uses.=0A=
=0A=
=0A=
=0A=
> > If this FPGA is the only device which will ever be on this LPC bus, the=
n=0A=
=0A=
> > could you encode the LPC accesses directly in the FPGA driver?=0A=
=0A=
=0A=
=0A=
I think this is the most important question. If the same SoC is used=0A=
=0A=
in systems that connect something else on the same LPC bus, then=0A=
=0A=
making it look like a normal ISA/LPC bus to Linux is probably best,=0A=
=0A=
but if the CPLD and SoC are only ever used in this one combination,=0A=
=0A=
there is nothing wrong with pretending that the LPC MMIO interface=0A=
=0A=
on this chip part of the driver for the CPLD.=0A=
=0A=
=0A=
=0A=
> > As another alternative, it might be worth considering writing an I2C=0A=
=0A=
> > controller driver for your LPC host, i.e. model as an I2C bus, and have=
 an=0A=
=0A=
> > I2C client driver for the LPC slave (FPGA). I think that there are exam=
ples=0A=
=0A=
> > of this in the kernel.=0A=
=0A=
>=0A=
=0A=
> How the host cpu is connected to LPC host?=0A=
=0A=
> Why an I2C controller driver for LPC host? The LPC bus is compatible to i=
2c bus?=0A=
=0A=
=0A=
=0A=
i2c is a simple bus that allows multiple devices to share a bus=0A=
=0A=
and perform read/write operations on numbered registers. If the device=0A=
=0A=
attached to the LPC bus fits into that, it might be even easier than=0A=
=0A=
regmap.=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0 Arnd=0A=
=0A=
