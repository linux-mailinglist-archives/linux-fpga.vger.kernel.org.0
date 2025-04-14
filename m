Return-Path: <linux-fpga+bounces-1158-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FFA886CD
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Apr 2025 17:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B525A190381C
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Apr 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155A2472B4;
	Mon, 14 Apr 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Rp2iHfd2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2424728C
	for <linux-fpga@vger.kernel.org>; Mon, 14 Apr 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642412; cv=fail; b=KlJ6c7NalXiTfF4Msz+VyHjkGdINRD0cXpkmVdX+zVYlclLmdnthMIYzoop8baY0PG8DB/LsnetGtRng5eoaZcJZKClxvlGkEVFhmQ6hpODhVB1uZi88XDBvL4kU/1tH35FW8Y8zvn+RoKMViyX07ocAt29YJ7R/AQcWzqiEWjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642412; c=relaxed/simple;
	bh=3kREOD8mA/ic77n6U75MoBGSssjkdp3bVYjrFPTdr58=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KU9GE/HD6UCDl1IsVE/CgtAjbTuSoNQUwRi6yU04eVCyvswOQlTyCR5po34fUhDU0FuDXuiiMNDn9eZGuIDeFc2AW5ScRp33Ezn55XAm8daSz6zDC2Vz842VFYStsywBsdV8Ewd0Jw0Sz5sB+IsTO2DVj3lsJvCGownN8YRFheg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Rp2iHfd2; arc=fail smtp.client-ip=52.103.20.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja/I3UmBJh+OHkEOX+zbScCvmLMBvxpjTbFg8+qh81UMMHVA9x2S5wc3nWM7/1Rf8E3LBacHXaaIixeBzH3k3utjqU/ysypoOzRIMFXbB3fPQDC1d3gG5IrgRd317zuktF5DQpJynb7i/INl1xR7EpTbBOujDwOaLas14rHln3rhF06AOkPBuJo1d2PeqAilNl33JiGRR+/sL5kbzrsIV7XGQwf6Wqax244Lsud0c7S/C/Vs0x97dgm5ssgQTtlwveziaQnbRxa4AjY03qyQsqK/MkGfOmYMOyQzGh8Unl0zfnJCufd2ak8kebNabsliRtJ5XmXPQh/ENfm1lE8Kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kREOD8mA/ic77n6U75MoBGSssjkdp3bVYjrFPTdr58=;
 b=jZ+lo0Wv+AwV8yf175o/DHB6Qb9xG7kygVbOpY43/FgPTj9dEVLgcHiKznnp2dzzvJGt2uXqMfB470BVJUxVBIQRV/BJA0Mi0K3u/AorAxY+tdJMr5Rwtp4IvVkHoz9GFiDmBSQJV5wHvOabMPQpE0dvSgkvgXR3AoRSHusAr7MBJn9s+lH6S0I9LNVdt7D+ffX6jtxvdVxAYtwSsVy5R2DeCVrvfTGg4IHcZP1P0UA5Njuti99lsDPTb5kldxvTw3joL+djPq2pNiD/6GaXWPUVxjrNI3BUW1vQgu/FHLLHC24pDAwnE9frK4HwYokgpQvPODsieBMpQuROV+MCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kREOD8mA/ic77n6U75MoBGSssjkdp3bVYjrFPTdr58=;
 b=Rp2iHfd2BiG1bHt7VDUU8g70Oh9jZNmvWxt50cX3EqlkxtHxUUnENzk+zHeNBIzwSxs0UIh120oD35IpvBcTdcCeX6aD5sy4tQTWqJcTc+kplM6bassh37FB5gYWFwoTzbJCOmn9dqA/U+SoM6cJ4KwWY9kK7S5Btj9+/hBZPIWW8WTS1Grj2vxJ+fiMsUwfYDxzigagVevda1crdq32popstRnza/vTkQu8eiu/szlYX81OGM+8LnSQx4L6Wo8zQ5T3bGT1E4fwn8R4lahBTu70Yi1agVV7fs5MsjVOtpv0teVmbMjM78XHYPeAmWChmke6/7ZoSfmeetc36JincQ==
Received: from PH0PR04MB7818.namprd04.prod.outlook.com (2603:10b6:510:ec::16)
 by SJ0PR04MB7709.namprd04.prod.outlook.com (2603:10b6:a03:329::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 14:53:28 +0000
Received: from PH0PR04MB7818.namprd04.prod.outlook.com
 ([fe80::2e62:9013:9448:74ea]) by PH0PR04MB7818.namprd04.prod.outlook.com
 ([fe80::2e62:9013:9448:74ea%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:53:28 +0000
From: Brenda Wilson <brenda.prospecttechconnect@outlook.com>
To: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: RE: Unlock aerospace leads from MRO Americas 2025 attendee database
Thread-Topic: RE: Unlock aerospace leads from MRO Americas 2025 attendee
 database
Thread-Index: Aduq6GakcHCLABl8QbaIR35AsaJBQQ==
Disposition-Notification-To: Brenda Wilson
	<brenda.prospecttechconnect@outlook.com>
Date: Mon, 14 Apr 2025 14:53:28 +0000
Message-ID:
 <PH0PR04MB7818AFBB535368C91BB75D5F94B32@PH0PR04MB7818.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7818:EE_|SJ0PR04MB7709:EE_
x-ms-office365-filtering-correlation-id: 060134f2-6b46-41c9-9664-08dd7b641ddd
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8062599003|461199028|15080799006|8060799006|440099028|3412199025|12091999003|41001999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Y8NfCaFNkzPaWqIzWOa5CXz1Cpyt0GQ/NqS4xbUatNXmAAyT1xPYeswjZm?=
 =?iso-8859-1?Q?NefT6DT9dHNfARLLiTFXXHVy1ulEkuNIDkeH1KkAwpv7lo2gPxtagMbbs4?=
 =?iso-8859-1?Q?fsP0mTEVQ8dywH0KEqSddich7ny0HEtczNlkTCC3kVXZOUw8wh645q0gGl?=
 =?iso-8859-1?Q?gfx5jegvJ7Rd9oW/g2XKeaZyFadmyBk7mGthVqIbXo6vGnKQZhBNGb0KlB?=
 =?iso-8859-1?Q?H7BQFw+lEekXY+hU+xkPa91CmXm23omOvAaoRsKg3RS1JvFpKEPIG7ZJ2z?=
 =?iso-8859-1?Q?CnBrDr7SX0gi5akeYcYLQhoc5EKpsD19LNofbCGRi68lokN7Zk88UJ22WH?=
 =?iso-8859-1?Q?kIjVJ0oEzEWs3LNQW2ufuVrHvEitm4jufMpTJBDbH4Yc8G5MGAIQugDGpf?=
 =?iso-8859-1?Q?8I2WMjROzTcIjNXLc3unWo7kyXdzdZdS8qaqUBYXu++EiLmmafUZeVP7ue?=
 =?iso-8859-1?Q?2KFoI1L/p9ewt9zkxS83YXBIf2MaE/8rcxpZ7mLclKENS6UxD7fGrCevFU?=
 =?iso-8859-1?Q?xsgl/YsLye5VSic1WbbcATva8HiGo8NNoIWhSePP6SEb2txrb64ZGfFjWb?=
 =?iso-8859-1?Q?0CqvpDnbYZPwIY2korXvyF7iAQo3i2Vd939kDv5ZJxYASN5nGuqYv/LKaC?=
 =?iso-8859-1?Q?w0TP23GC7zMOnTQ8Bmw5RurjD2pgzzZVblbY08NDaEqbs/I07MshY+9YZp?=
 =?iso-8859-1?Q?/cbC+T4+YgN5riaJ55MBAMOWEe+dlFc1CcQqK7S4c1d4gabAxrNJdHxEGK?=
 =?iso-8859-1?Q?j7+M3ZUmgOfgDTp7Vi0C+1pal1RDYJ1SQgqdub8hwmOiFqTyp/uQg6XUnl?=
 =?iso-8859-1?Q?KAOaN5Utl1K53NEErrvUbVaFT6cPzroAMY/C1VyT5pfq9LAVICoUAqo94b?=
 =?iso-8859-1?Q?JchvXKwfchqqsBeAvMplR40cxztKOZmhs6akNSn+v+YqSGtgU6E3zWL5x6?=
 =?iso-8859-1?Q?4fwEe+dMdG0hSC2WPuLmwmq9mlm1nKrQa0GgktQ9/6z2sII8POUXWH7/B4?=
 =?iso-8859-1?Q?qsDSRXgdjHqlPhXZWhmWDJ6NlpMlWgF2ll+SpCIB3ILCpgQcEs2LS6RRFv?=
 =?iso-8859-1?Q?6uHWG1kWQGVuD7MuOIZqsKrsA6ClkP5AXvw2+1OMX5xLAh38Bcie5Xh/zO?=
 =?iso-8859-1?Q?P4ETk47ujpgEdm6Ag068kvZ+oH1uxhJmyUrfBJhrkHlQBm2Ff0pTnGKzL7?=
 =?iso-8859-1?Q?bNLFc1AU+na2uA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1EAGWHGYp/0Gl+nKSL9JtEU6RNzIytn5syBhpf9h1sBSSqujGP8npqVf+t?=
 =?iso-8859-1?Q?uMgXlhpKlPO2kXfJgLh2c2QoANXBavIMhLIqDGXyJ5jSh2KBATZQzVBilt?=
 =?iso-8859-1?Q?S26XecoQc0ZrzYVt1OjBXVWvzzPuE6c8yDh+p7pfryRzoagQExg1xGTd5c?=
 =?iso-8859-1?Q?Of7V/YnBXnMEFBR9aAu6Q3fgkI1UdyCW1ieyHO9WRNZi3G8aJ1vhTEGG+Y?=
 =?iso-8859-1?Q?gtRPtALkOxMXxhZ5DkU6RJbJmUSyuGd9PEqV1nu8nA6gRBHiFfkEOvxgYb?=
 =?iso-8859-1?Q?gw1K4b3nXZtS/FBwcr9PEKSVfWlHC+dlNKHVIJqE0KI5IwQuWIC7UcifKo?=
 =?iso-8859-1?Q?MNsf0kTsnpdKTsyP6VcatP8XgUtmEQyTJVxxNR4CexqSgA7mhEtkhRoNdK?=
 =?iso-8859-1?Q?1R7uWf/6c0lDtNP2dsmDC7zcUjXj8qVaseY7MsQwTzjiIHioyNpgCmzXyA?=
 =?iso-8859-1?Q?KPFmvYhHKIoCj9l2qLqhF/RxJ3V9EuLKaoAmbDQKe+B5H0zvrYzYrMaVNj?=
 =?iso-8859-1?Q?11oYBPvm/du6WyT2BG3IyPJk+yQZ2hLGt7DdQSp0ZN+Y89tTpqN2i0PsMI?=
 =?iso-8859-1?Q?VrXiieCXZBDKgLJeeTsde+Fp3tUoVJKoYH03luZeAXXqIeKsztCSVRXI4v?=
 =?iso-8859-1?Q?Sn2XucbtW9uFkRgEzT11rFvQ9C8S1Ay2CtJ/WtF/Yho9j4J5ic4aAr+Ydk?=
 =?iso-8859-1?Q?WA0LzNN6ZaYItMCUpAWaDM3k/wYN7HfjZ9SUkUm/93ZYLbsWBLacKNqxVA?=
 =?iso-8859-1?Q?Q8vki036XFGcYqXPjwdhZF+7Flt7QImke9ox4AlNhTfKRHjfhax7bDUQy+?=
 =?iso-8859-1?Q?A4qoLQy1iwPZbGMkdMkgWuyDrWLLHYXYk8OBkuX6FT3574UA4v853gXd/l?=
 =?iso-8859-1?Q?HcHEuTCer1knhwd8zU2dgQIQnMCa+r8T+EGQoAedR2giTNk7Qd82uo9/gN?=
 =?iso-8859-1?Q?+40wSZNVYmLhNnsAdTfvFNA7j7a56yrzVcfuXcPKWsvBD2o/5ZAtf4YJs6?=
 =?iso-8859-1?Q?VKGB1mo1raIu0kggDnlX4JCbgf5akoFon3EWOU/xzxoFp/Q3CoVyLRNa3Z?=
 =?iso-8859-1?Q?GW3qyRDOmZyBfbwNJ/SmY330duAh4JXFdVp/UJjjZtj5BZAn2KamX8KiBH?=
 =?iso-8859-1?Q?9AN6xKAGi4ak6ypOKAj6XEDRdx4MXgJplgptL8xYWEuZQD/CW6R/R9tLLr?=
 =?iso-8859-1?Q?kotdweCrLmR1pFQ7ETY3HwPfAjYlDxavZG0BqL4dztbDzqp15LwXk6DZcx?=
 =?iso-8859-1?Q?+QYkVD2nd0bTVbBCqzzSf01Egpa4ZAcx9FzUq1OPk6AOWPJq3F9CZaq5Nq?=
 =?iso-8859-1?Q?D3EdboYhjy0eGf39Uo8HeUSVih3ZE07R+odMotKp6aM99fKqcRxRoZuQ1H?=
 =?iso-8859-1?Q?VVV2HCBVQ0b2U7zSg/vBePrkgYSeqPcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7818.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 060134f2-6b46-41c9-9664-08dd7b641ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 14:53:28.3907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7709

Hi ,
=A0
Following up to see if you received my previous email.
=A0
Let me know if I can offer further information on the figures and pricing.
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails
=A0
-----Original Message-----
From: Brenda Wilson=20
To:=20
Subject: Unlock aerospace leads from MRO Americas 2025 attendee database
=A0
Hi ,
=A0
Is obtaining the attendee list from MRO Americas 2025 part of your plans?
=A0
Expo Name: =A0MRO Americas - Aviation Week
Total Number of records: 12,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.
=A0
Want to go ahead with these leads? I'll gladly provide the cost.
=A0
Excited for your reply
=A0
Regards
Brenda
Marketing Manager
Prospect Tech Connect.,
=A0
Please reply with REMOVE if you don't wish to receive further emails

