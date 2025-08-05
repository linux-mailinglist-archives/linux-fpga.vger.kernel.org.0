Return-Path: <linux-fpga+bounces-1293-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43CB1BA7C
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 20:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52D1170133
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Aug 2025 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4E215F6B;
	Tue,  5 Aug 2025 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iDCo9aIC"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147441E51EF
	for <linux-fpga@vger.kernel.org>; Tue,  5 Aug 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419962; cv=fail; b=b6qxin3jS8eAFSh0dLSl9mYkyNt9bHh8nwH3NBuc0195X2AOk0bAsyTZGggdySkLfHMVkn4lGGu9FctFYuaqVy3gD8Lv2wfQ5+YnLPI3RAJ5I7LoGHd1BSIl7Xeo+xRKpxUkwO91r6TxcoiNjs70VzsZR7O3RQNsgaf8dxgWi8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419962; c=relaxed/simple;
	bh=1tTn7aJLv7uIJam8fjXyYGVG3Yh8+7b+YdnLmOubtnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pv2eKUVnwj4m5s0dV/zqS+LrwqT7Mb4mEjL1mloF639DU2Vx9Si5PiM25RBHu6WXC5L8PrXAmzLZEYxDqhpQ/w6QjxUvMmQh6kkEGXnHmVY/fdqY+UK3zC0UWoTsnKA6O2bxG+ojvfbrJg20upVC/mJaoImf4IHWiClXRXPmJlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iDCo9aIC; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqW4DRFl29hTs7g9UZ9YkBQo6Pkw/AMAbusDmXFn01zhUv8e42lRCO1qedl6DhquOH+t0QhD/b39ve6P192uC5a2vPA+i8XRUfRxYeoRC6usNTvsNzAXVLLmoEGtiy2pXDLeUlOSC9f0R9YrmgKA4LnrkNIABbaKI1gJhSxLv5Ch1+uCozpHI55iKFpBiDErZxtFbtzDvQAiKlXJDhD0W22Q9v5BzWU4EnMmfmWgrgkeiE9hhHblC7eM3/JXPj2uItbDbt8lxwIypF93RInjOLPh3Ur2BAD8acipHAnO1zS4LOypZZz4VKN9NyUgWd3p+WN6/hKzwkq+Czi8cAaK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsC4IRVUl5fKYJnMT9q4OXv7qggo4dwm05GZzW+oN14=;
 b=Pi5JJvUWBEdg1btPUzH8zCa6KTWLjnrIxJA7uKUy1+3w9dLqtkg7wayYBL4eEbQkg7W/EX6FuCW+wIuihGZwZ50D0lnWSiOX6iAG0bAcoGy78zoHtyKKR3fZ7R95ImGXC6ugPgbRYdAZ2Ev9yzikqUqUlLW98et3zNR7FFBMNFlLdrSHlfXv5x4VNzEIhvXQ+r3m/dGE2FpZddSlqhhnDpghdLNXelfHwm2JtTOZO70ovqUQkh4aXkfrrqOOKQAXgi3R9cvD4Kb+9B/G922NMo5D49ChC7yTlh7Q0FWIZbdu0r9W1zreT34oU4eH6JxLY/P2Ve5CXnKbZclSwExVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsC4IRVUl5fKYJnMT9q4OXv7qggo4dwm05GZzW+oN14=;
 b=iDCo9aICyXlZ4IUTs2rvB8ENtdec3y2OQklCJNQKrIWhYqihcmWogySqM5i2qyDWSaorOza0a8wy7313TrVm5Mejgzp50C5pVQS7Qo3Zww1TyDWBOkEyCqNloTx68tz1XbUrLPrMaJTdmFi3fjl06AUk4kYaLRESjmxGLwzX8h8zEAgplP1C2HB1W/LR4fDCpKb5tENBQnTQv+TBn8fKQDHIb2oFi8SOxDwSCVu4Ft4xmRsQaJHWiBw5q4fsLq1YXebxwxGSaKPrTFE257KM4AZxJ2CkcZ0PqcB2UstSES8iGhvTliluMqr2Oklzk6R4qYghQm8rdp9ubLJ1et1ODg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8263.namprd12.prod.outlook.com (2603:10b6:208:3f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 5 Aug
 2025 18:52:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:52:36 +0000
Date: Tue, 5 Aug 2025 15:52:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Pavel Pisa <pisa@fel.cvut.cz>, linux-fpga@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>, Xu Yilun <yilun.xu@intel.com>,
	Pavel Hronek <hronepa1@fel.cvut.cz>,
	Jiri Novak <jnovak@fel.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: AMD/Xilinx Zynq FPGA manager stopped to work after
 6.16.0-g283564a43383
Message-ID: <20250805185235.GP184255@nvidia.com>
References: <CGME20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7@eucas1p1.samsung.com>
 <202508041548.22955.pisa@fel.cvut.cz>
 <a3b997b5-d8b7-4c72-89fc-7d2d21031351@samsung.com>
 <aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: YT4PR01CA0445.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8263:EE_
X-MS-Office365-Filtering-Correlation-Id: 4746fd10-a224-46f3-142b-08ddd4513ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLs8ymq4Dx3OQG4Ai+6qcO74sN/DN5IWWXJzWFeaiaI7DpkEzz509HJzUrLO?=
 =?us-ascii?Q?CDKZ66XGCiIFAafYwDRDk+y1LIYH5ZYjm+++vPTIMCm0GOWURnKZtlDjiY+o?=
 =?us-ascii?Q?6xu9QLIY7agVVrJB4ndzQRSU+3pornakcQi969oqpHn2sOcajKUH1xDR0rYl?=
 =?us-ascii?Q?kqDfYEzQV0ECeU4U6ZcJJx4Bl0EVc9rpiqxymYgS4d7RYidx6umyoOZ+4vhs?=
 =?us-ascii?Q?S6nUERc/Q03GZJbUAbtkH52HjQmRFQWtrK47ZrCey+OZosmJy2hea7i07fuZ?=
 =?us-ascii?Q?DJ1NLwrtPEzEF8fZPMwh1lK2KQvHF9hbWCY38LeGOO1Q/ipA/z5dNvbE5V9I?=
 =?us-ascii?Q?axgN4HB03TqDbStqH9yNJQJhwyObtqYVaziMv55IhdF8gM5CXkDfjXoxAMeF?=
 =?us-ascii?Q?Un163E0tBwXgTomPTBJkAYG3WhRWKRT/YL/NtZHMyTNKfMA8RO3nnb8/erAe?=
 =?us-ascii?Q?C9UMqn/nDt1xInSt0N0Yh9uu2AN+dn6YfHzAtaMli+k2qI0zFQLmc+sgEYjI?=
 =?us-ascii?Q?BVTy1cF5CA0lOZyajTExO7qtmhPLZKkUF5NlF1UzsFsZHu2+iOj87HX21DX7?=
 =?us-ascii?Q?xY1AMX61KJ+R/oASzif1NAQK4Lx/gaLRUdOyOKbhuXI0Dq5N45E3Y/A6+2yz?=
 =?us-ascii?Q?5NVzLS9P9zSUt3OYxSN/T25s/ovxPN5z+DlvauApu1+TwpiTtAZnqsviQYdW?=
 =?us-ascii?Q?v2SSi8pELkPLV4Jrcm0Dx21LujZe1qnCTdPzboM0EO1LaIdGmDEl8wVRNX9S?=
 =?us-ascii?Q?ZCenDeW/8xrAmoyhrQoJO0QgrHv16tshF18ZPA12FPL37/HxFVVu3z3kOmMg?=
 =?us-ascii?Q?0/isxLFHItPeh6hAUDlnddy/Hnp6pzH51ojOp/I77cX97Q6nJ5kcfbco/PaS?=
 =?us-ascii?Q?u7t+rOm4j5Ya3EZYlQiSpUtL2/BZNLTGYNoc4E4IA+0+yTlxGrgMgVZMrsDP?=
 =?us-ascii?Q?lCtBovcc9WTj2/CBvyaPIhztA/7kWY5nhJrtILope6BX1xXXOw08KBs/jV6z?=
 =?us-ascii?Q?jgSo+i+7MXklWHVse7VmvYaD+JPqgVZsHbb4lf7gL6f6dyIJ+fp4QYWh1Rkd?=
 =?us-ascii?Q?JDhFOAlcB6B1kZKyRxN5YNJTu99p9XQxaFumaFiHzHOfWQaJq/E27aHZO/lz?=
 =?us-ascii?Q?WYb+2xSpSOx4/rZPN6xNZzB5LwUVlm7DXRAJTdJNGZWOg88WL0zEou6XhHqw?=
 =?us-ascii?Q?+9ytcuquf5Vyqyr5186ebE5+Fan7966zlYn9kFsLmW51/0bSTll1EFKKpAyW?=
 =?us-ascii?Q?nM4KXS7fppo1lBawTbspX+KIUrkdNF1pmugVBUGYOW1G9n1ctklGfmcpHEdX?=
 =?us-ascii?Q?/sHOGvm5/dcKXGh9J1iRwuqztedLQ53pfNaKqA4gnNmzsbn0iW/Znv3yy9aj?=
 =?us-ascii?Q?hHWlHIdUUlYysbUXbZeehU+LLpl4d0xjUTKkb3IgonxyrYTwnxAmPSjrS4dF?=
 =?us-ascii?Q?b5c8I7k8t1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDD7p6KGURBgBs4pjjywgWljxuvTjJtCEUsg0T01Xc3m7De1GL6J1xPayQJ6?=
 =?us-ascii?Q?HrjN3J0twfVgkn8XbVQeN9layZZNUSyoaKqTFlG8Y/FsnCDqt4+ablyOYa4D?=
 =?us-ascii?Q?MWT6FRgeValNaWqk9Qq0HeawxOtOyG9xGEXuvuu+5NAVrKmorPahTJ+tc7ok?=
 =?us-ascii?Q?8LBBlCehqRLPKECTOlHb5nq6Dhn7xkenPnM48/jeGLojyJ+kphjahqfei/uR?=
 =?us-ascii?Q?GPcEcBt41uC7l2IObpI9GtiDHXaNzeZckOIcD8ETLnI/xPBKh5+aMaUp7GuW?=
 =?us-ascii?Q?yVTRXN+gUDjH+2h2m655jA50kc20RmtEF4C1ILnZrsvwMeduxIGAmns1ACW5?=
 =?us-ascii?Q?BVjZtoZgD6dk9x69Q6gG5OFJZZxrB1rzpg4RkyaSL7aW2qreh3z7KF8OhKO0?=
 =?us-ascii?Q?+FZn9hExpXhmuSSkAG50cdWet2+dect/GmWiF4SeCiv5dGPmDGnsflpM86ET?=
 =?us-ascii?Q?mkEzWORNs1NH013/Elt7haTtEH8z0kaeBzVSCpRua66YB8DG7Nnuz2VEWFWz?=
 =?us-ascii?Q?E31MGQ0z+M74repxz7DHtTkmXS821Y+6OzRBa/B54+QKj0Kg5lKLC3xTEJVY?=
 =?us-ascii?Q?UiwYr1F4reNqbrFV8lvUvrLYicJaRaUCG5WR7XlA8H7SFTydFx3A9ndiq6np?=
 =?us-ascii?Q?iR0emJz7Xc6GbCQoRfvZNhovAAcr4/HUooUcheMDh5dQRxafGe+J09NRAP3w?=
 =?us-ascii?Q?ACCv8/hrnH3fcleKSrpSdzg/3fV5RbJZmMQeD7o1Hzm2mOZufXlr9rah2wE6?=
 =?us-ascii?Q?097e9Ktcsk80ld3o350yuGND31y1nz79rVHZ83HwoJkQ1QNlrmQOQkoVcwqb?=
 =?us-ascii?Q?4S2DAXzY/cW+T0dpl55GVMFw4tb1jXnLGJpk6XGobwCwUeGPGSSOeq2WXA4V?=
 =?us-ascii?Q?hSukQjPLJL/76tPd+NvTAFUSRTYEGzvXDYKexBpEn5B8EnzsYaxWr/XqEQV2?=
 =?us-ascii?Q?IrG8ouAQBDMrXp7liVYoK9bAzv7D48eEASwVVKKO9d/DEz9wd8I7whPi5i+F?=
 =?us-ascii?Q?oUGFkM9Xy/YAgJRaOfD9M47NgoENyQ7V+q0tk02U6l8G4yyz/dkNUQyDqLfd?=
 =?us-ascii?Q?2j8Vhk2xfRGdGINA0qQhALikJP8eb7g8gjp8cvtcS98Owcm2mfInZOnv+WpD?=
 =?us-ascii?Q?BF7tJuZVosMiomKr0qyXqF4GOrGSLHTUAMrTUh6Ao1sTyTBHXh8XqHsLSHJk?=
 =?us-ascii?Q?qTvFKOp8Fh/o/x4vr73C4g6mO/5+Lk+AjC7qco2VDa5otktrINfWP4NvwFCt?=
 =?us-ascii?Q?HvZ7k9rMnAkrCRdLpx/MqwmVIU3n5oAyXgIWgeM/y8NbJZW9jItFvx2ZGyir?=
 =?us-ascii?Q?/gtVFIPQxIzUNmIMjVmYssXfzKRjpkYsu24sQfLMKtx2gu3HIx5gT2oktV2Z?=
 =?us-ascii?Q?qNNdGq6ENtLBFHbB0YMXSIt6ZzsUeBXmb0lfH//V4o5YB3aSSyG3tTG9rskT?=
 =?us-ascii?Q?KaoWT3KSwnlyFj4KpTTkrOHekl8ViLjnW6EFr1hBYiitCTx5bq3g0GsqD2q7?=
 =?us-ascii?Q?7GmEJ0pEUg392tvS/Te5homR7DcmsgESI/Nsrqh7JhmUapwzrC0lT76kE95H?=
 =?us-ascii?Q?2w0312PBCqkLZZ2AAyU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4746fd10-a224-46f3-142b-08ddd4513ec1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:52:36.8250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJsBwr6IwWMXR15ffFBa7YcEBdaAHft1BlJa+ksDcE+U7qN22SyMaLK5yhzxFsg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8263

On Wed, Aug 06, 2025 at 01:12:46AM +0800, Xu Yilun wrote:
> @@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>                 }
>         }
> 
> -       priv->dma_nelms =
> -           dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> -       if (priv->dma_nelms == 0) {
> +       err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> +       if (err) {
>                 dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
> -               return -ENOMEM;
> +               return err;
>         }
> +       priv->dma_nelms = sgt->nents;

That looks pretty good, Marek is certainly right the original had a
bug.

Jason

