Return-Path: <linux-fpga+bounces-585-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C293F317
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 12:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE5E4B224DA
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 10:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31A144D35;
	Mon, 29 Jul 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BSlha8A2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5828144304
	for <linux-fpga@vger.kernel.org>; Mon, 29 Jul 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250055; cv=fail; b=DUkLimPBg4bcQsx/0ZVAD3fCGjOhWrvO+87HBeOcGS5lwpaI0PAFsPa+lPfvikUzeNXlGq3OAERoXG8DwFHWXlSnp/tnQqLPh6DUSIlAKAJu4SaCQ4U4SIu5Ssjs47YgT1Bf/XLOUCXQyg2swJLYS1bcdVEp4F7mu+0xT9XFw58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250055; c=relaxed/simple;
	bh=sBXYjzJBDoyn91EQMHVIID3UgcZe1Ol9uZW3IAu3cUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=leogqZpZCzkTTZo5sLzRNWl4hZlhmf8VzdU5ETd9UtPhUNy6Rl+8x28BYMhCLD2Do5UPrNMBBDTcjXyRSZkyXJhy6MGyD3GSvrYX0EzilUCV12ExLkxzAmUYUrsvVss/E7Uot8m6kl8cIRB7+X+1V6XQFJZsYlL5Xeoc1gWJpLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BSlha8A2; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvhghPUfG+3SmyYrZuqPnoI6QAm3RM4YgOe0ErsN7aVZmhvUPNCsVGJNX4DdWGtNMsOnolytZU0KzTOlNHUMUyLdjBbqZmE/EBoXdQ+QqDpD7RHx8ZaODDVI/qUSkMQpVmdN4pt4VtAjtvY3m64Iu6zD1+DRLdlitX5VfvUWLJFx5/HOwqFheIg5jsU36/OYFxOPZEK3domVb5Cq4cZrrX/TL7fmVrcQpf9hiFaPrb9onoCZ82jrYsOxgesdFEEldno7abjCabE3BrsTnkpY34XCsxefGS7uU1bzy4eDSeVU5v825RJCBvAhsSZWoZKdUPnUGrOJbe2Sr1YmQpk0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Snqnkx/H58y/j1IaDnYqY2fxRr159CZvXLXEosHUbE=;
 b=dPVeV8LtwGTQp+6F3S0N0ZQXHsywRy+dZdJo+nF2OBE/Q3eP4Ir1wjrf4GpZne8iGPIosiArYP9eBFKuIqaKrcKFuNzrSH56ZQs2+A+DHmJXI4N8PgYTKmzBhCrqMmr9ZV+znvIvd5V95GIe1YEw4hEiin+FfDk9Ts6MMhq6eB6eIxO4bDEkn3FnR529iKjFZkT1oii3MCT3Ul5PX/eO4j+hpDwySXExlBpmhRPVw2g85U0zPU0S3KYBlA80XxGT7SoSOist6+9P8vq9hC2Vfhq1KujzLy6yPBuH1LLalMQUA7qOHcoH2hnBpzirZlUpPiFzWpPU7wE6zW0rpxOqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Snqnkx/H58y/j1IaDnYqY2fxRr159CZvXLXEosHUbE=;
 b=BSlha8A2nPI5XH70U+apSLI/3/c++re/CnJK/26WZ3yQEvXZTrJ2XKD37qwnxW+NeMkZRuAqHGwgiNJeO5bjsUhtMnij3hnzIVCJLoqonl/IHoq+kIXV89BSE8NEqcFu1m2pPQZlj5GqpLph65fhdhqsyLG49l7PJto3hqc6/SM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6720.namprd12.prod.outlook.com (2603:10b6:510:1b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 29 Jul
 2024 10:47:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 10:47:30 +0000
Message-ID: <2fc6ec36-e945-4e62-bb40-f08e743f893d@amd.com>
Date: Mon, 29 Jul 2024 12:47:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] fpga: zynq-fpga: Rename 'timeout' variable as
 'time_left'
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 linux-arm-kernel@lists.infradead.org
References: <20240729104319.2658-1-wsa+renesas@sang-engineering.com>
 <20240729104319.2658-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240729104319.2658-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:803:14::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 406728b9-5076-4b1e-d874-08dcafbbd894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3pxVndma3h5RWFSbE1zNkVvd3VGNkg2NWlSeU5WNklDY015RDBxcEhoZHFG?=
 =?utf-8?B?OFJDRjd1c2NqSER4VHVwVndnNmJ1Yys5QXdyaGJtZloyMGdhaGJhUVZ3V3BF?=
 =?utf-8?B?R2Uyc0JVdm9rTWpTWUczWm42SDdQTGdsdFVCZkFXcjJQQTV1aXp5cXpId2Jt?=
 =?utf-8?B?OXcyaEtPemVwRE1hRlppdm02RkNSeVQ4QXorSnA1dE9VQ3lRU0lVanlwbVJZ?=
 =?utf-8?B?cnduaG5TNzA0Mm1LbVVncTV5b1QveHZNR25ZdWllU21mN09Gd3AxdHdPaXBV?=
 =?utf-8?B?YWM2WjM2V1daZXpFU2JRTTRWL0prNk9CYVc3bUNpR0pWcVRuQm1rOHdua2xT?=
 =?utf-8?B?d0Y5YUxkc0RxSW4zUHkyait3ay9pbVBjRWRUWXU4ZXZ0VjdoS1BleGYvQjc2?=
 =?utf-8?B?WUFpbDlxcURJb1NjRnJIaVJSVnZQcXI3NzcwaE5IQXQrQVZGUVJwdGFqVGxo?=
 =?utf-8?B?YjdSZWtUbU5oQWhzbWx4R0pLV2NaQ1hCWVA5M21pZlN6SjYrZDJzdkhGNFpa?=
 =?utf-8?B?c1N5QzdHQlNhNnc0WkZqY2E5L2x6aTQ4NnBLYTduamtocy9jMjF3ZUNsa00y?=
 =?utf-8?B?NEozNTJtUWdNaGppYlJtbHR6cXdsUzJFQ3Z2K3ZSTmY0djZ6Qnl6SGNIeUtz?=
 =?utf-8?B?TkdCZUlidkNWeUtndGljaUlrOXhxSFMyYkVhWmJ6eGdEeFF4Z3lDM21WUG45?=
 =?utf-8?B?YWF2OERhNmNrWWRENllWTlp3YndlYkxkbXpweTFhWTF6UjhtcklQMGJLRVR3?=
 =?utf-8?B?VThzTGgzUm5lcXpEdGxBRW5NWE9tT3lqZlhxbEZ1dUZtK3ZTWHRzTk8zSkNL?=
 =?utf-8?B?alNBT01IbVBROFNaMDNkTUduQmUxb0tFK0taYkF6VjJPZE42dFBjNEh6TVp3?=
 =?utf-8?B?Q2xNM3N3NWd2dlN6WmlqRHRwU0RUU3phOGlBZWM3SzVqVjg3NkNyY0lxRURj?=
 =?utf-8?B?c3pwcUFvTDZoVExVZWdWMmxVSFI5Q2pVRG9lWFNSdEV2Szc3Ykd6T0dJMUIy?=
 =?utf-8?B?aEM3VlhuYmt5TkUycWk0TUVqQ0g5TC9LM3NMdU1rSC9XMWF2eU1lbHMzSjZX?=
 =?utf-8?B?UHZWOGoybllsZ2RKcXhqVGkyVE5WcDNORWU3MmFBQmhVZS8vK2d6M0Z2a3NT?=
 =?utf-8?B?dXAzSzZkZjEvTmpPWmxUeHFiWWszMjhVNW5EUVI1RU9QVEFZM0IvY1pkUzFK?=
 =?utf-8?B?bTkzRUZDZW1PN3MrMnpQQzZWb1ZzYTJETXp3cnFrUXJlMGM3eTloT0xpWUE2?=
 =?utf-8?B?OC9SdmlWOVNnT21kT0ZhRk5Tcy9LenN0ZUlrUHhnd2JudGY5NEZVNmhpWjFs?=
 =?utf-8?B?eVlrU1NWMlNRZkxQNWFtZGF5bExLMDQzK2xlWHdKdEVWeXdLNnRqbTRwMUlF?=
 =?utf-8?B?RXY2YUd5OHR2dTh2bVArZlZ0UnlDdHZrRG9XQnpDcjJVYWZkaW5YSUZKNEFw?=
 =?utf-8?B?VXFUc2JramRYb1lsVzMxYjAxZ1Q4ZzFYS0xTZFp5SWVLZDNEeE9vN1RrQU01?=
 =?utf-8?B?WU5lcWRRalV1Sm9UUlYyZms4UDAwNEd3YStKeXErR0tCbUExem84TmpidmpO?=
 =?utf-8?B?SjJjVktzWFFjSGpLUjlKSG5EejBjTWZqcjZKZDdQVmpHMDZvN21wbFZzdjVw?=
 =?utf-8?B?akZyVGVVWEdFcDRPUFJQVTZ5NStyb0hBMkRJdjV3WmJsUU5tTkk1bDVWVG1O?=
 =?utf-8?B?VXFsNmY3dkplbXozc3RPenFGbWpUZk1CUkRXSHZrVU5BQVZWanZpTEpRSnAw?=
 =?utf-8?B?aTUzRjI0QTd3WHp3VGxzUXlNRDNCWHVqVTBxZEV5ZEVYTXhweHoxZlBzdHpl?=
 =?utf-8?B?MTFTajBLVmFSNysyakR6Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1Bhay92MHdmTGFkMlR6S3VDNjFveVhCaDEzR0pxTFZIQWpIWXliU0FpZHZN?=
 =?utf-8?B?bGpGcFIreGpRVE1NZC92RVlyckM0djRZSGlkZmFaNWdQNXVNcWtnNzhBbGR0?=
 =?utf-8?B?Rkp5VXFnUTJjNEFLbTg4WjU1SmJRSjJySG51YlVUMkRFbmRkUEZETmc2YW9u?=
 =?utf-8?B?YmpNMzFiTXMyN3dZTXl3YmdRdWJCY2ZiRUo4WC9URjhyM0VVN1orN29BclpE?=
 =?utf-8?B?OWZBNWhGelhtZHR0T2JnMlNaK2RlRVl4SWNUbkxBMEYyekI3OEd0ZzFScUU2?=
 =?utf-8?B?UHNPNm9mQ00xR0xFTi9KMmxXOUp6YlJ1T2ZZckNQRExCdCtUTncwbytkSk1I?=
 =?utf-8?B?VkNVU2QrTzZ4bTRtcnNCNGNKZUczbXZUenp1TVh5Z0xGL1NGczJrMWZvc3pE?=
 =?utf-8?B?cU52a0Ezc3lVa2J5WEFNNFlsK1pQL1I1Q2NkdzJJcEJVOXRCRnI1a2VOK1ZL?=
 =?utf-8?B?MVR3MXJzcVRjWStlVjQ4NUlka2VZR29pSVpqL0drNHU1bmJvTlFwWm5DdjU0?=
 =?utf-8?B?aWlPaGdMMmZLVlhtdWxHSHI0WHo0R2M5S1ZNNVRpR291UDZobEV4UzVRNWpZ?=
 =?utf-8?B?ZUU2SndFWHZ1dDRsSGszUCtHdDFCb1UrU0ZPVEYveEJsbGlJTE1EZ01Wci9v?=
 =?utf-8?B?U0Q3NzU0MWI3R2llTnR3dzE3M1JXbXZtM3R0bjd0RmNyMm5rY0hTOHE0UVYx?=
 =?utf-8?B?V3crZWN6bVJta2ZkWEQ0N3hDVHpsQjFSWHY1b1JLczBiZzN4V0dLQzFocHA3?=
 =?utf-8?B?c1lNS0tSaXRpTzg2ZHQranp6Z1hScmwreFdIUXpPQ2lmM0tpM2NNMUlJdDda?=
 =?utf-8?B?d2E1ZE4vNU96UEdBeHo5ZlZqUmFpOHdBRGh4QjRBSGd6c0k3Tlo1QUgzY0pj?=
 =?utf-8?B?MVJuUDkxekgwQ0plc0FjQ1U1V3pUS3dTdlFxZXZIWlZPMk5ZTDNVMmNMUWFk?=
 =?utf-8?B?ZXdNZUFydHdaVlBRQllDNFRTTWJRWjc4cFJFbDIyMEh4alo0bzNpbnJENStr?=
 =?utf-8?B?OFdWRzc4T0pNNVVZc3pMVHlqZkYvVWNja2wvQytzMzNCRWxXcmcwU2YvQVQ5?=
 =?utf-8?B?czBHRkdUREUxRkl3SmxncThyT3lRQ0oyU1YyRHE2bkVabm11QzNyNzR4TDRE?=
 =?utf-8?B?WnhISkx5T0F6Mkx1TGZkR2M1SS8vcGpFdis1NVFwdUV0YTRCczFNMTZXWHhF?=
 =?utf-8?B?bGFRcXBVQisyNnZZNE9CbEVUT2lZZnREZzFjdlNkMU91UjU2TmVsTUFyS0xp?=
 =?utf-8?B?VXVQcitJUXBUWUpwRjZqTkpBKzVYdkY0WmRJSWt1eE04NVIyV1AwYXVQVzAx?=
 =?utf-8?B?Z2NjNVd6UDk2ak51Nm9CVGtCbklWYTdkZlBLMVVyVWZZSUFISkYyNG9qbVBD?=
 =?utf-8?B?Y3RDWVRxTFI0WG8zajQwM01wU1NraGFtMGVuczFDOStKSXRqb0pxSjgwSjZY?=
 =?utf-8?B?UkxrdG9hTERUYWN2VFR5b3FXY1BWOHdrTlRWczFndEJiME5PVUFSOEZFZDFN?=
 =?utf-8?B?djFLdTBUYnhLY0JRdFhEb2F5M2dJbk9uNzF6S0xodHhaZk5QeHVlZGtGUTlp?=
 =?utf-8?B?VkUzV0k5UE1MVTJPSm1jZlVaaW5xQm5qckhyVExKdzA2eVZHZWZONGF0VlFJ?=
 =?utf-8?B?aDZDVEp1UmRkOXZMdmI1VEVHVGN3L1FmWEUybFlZRkZIZVBWWFVJTkRZcis4?=
 =?utf-8?B?MFA5ODNzb21LTmJTbjRPSU5xZEhoQmJDd3NQN3RjYUp6K0pJTWJHbGhSRXFo?=
 =?utf-8?B?VmpSanhaVVBRRFFialJLZlZ4M1I0VU5nT0V6THozRmhWeUJudE5YNlRSVHp5?=
 =?utf-8?B?TlV1VUJ1NjhVcEtGckdWbHdUeUlBLzFnWDFFZWJpUU1ocUFLWGNBWjN2Unhh?=
 =?utf-8?B?RDhwS1lpbk9nakpuRm5wMlJUeWw5d2ZiazVnaWZ1U05CeC9nS3VTZFF3ejVZ?=
 =?utf-8?B?UEZXOTdnZFc1bytGZnNreEs3RkZjcTVoKzNpVmNMUVZsQWJYQVo0eU02b1NW?=
 =?utf-8?B?YXBzV3NwbkNuaXdGNFJuRnl5aDl4UjZ4Z1Ezcks4dkJiaEFmSVdLMFcxVzRK?=
 =?utf-8?B?cFVmYzFzc1prMUZ5N2ZiWnZLbXQyNUl6VVkxSFErQ043Y3pheTFlYzRRNnZY?=
 =?utf-8?Q?kWcZJaBbkjuLuYxLNvqcomCAS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406728b9-5076-4b1e-d874-08dcafbbd894
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 10:47:30.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgCwsxRr7n9xaU2AfTKcjWaJuF3tB3v5VNui8o69/KbMQtP8E9proFuw08tQnwyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6720



On 7/29/24 12:42, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named
> 'timeout' to store the result of wait_for_completion_timeout() causing
> patterns like:
> 
>          timeout = wait_for_completion_timeout(...)
>          if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the
> code self explaining.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since v2: reworded shortlog
> 
>   drivers/fpga/zynq-fpga.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 0ac93183d201..4db3d80e10b0 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -387,7 +387,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>   	const char *why;
>   	int err;
>   	u32 intr_status;
> -	unsigned long timeout;
> +	unsigned long time_left;
>   	unsigned long flags;
>   	struct scatterlist *sg;
>   	int i;
> @@ -427,8 +427,8 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>   	zynq_step_dma(priv);
>   	spin_unlock_irqrestore(&priv->dma_lock, flags);
>   
> -	timeout = wait_for_completion_timeout(&priv->dma_done,
> -					      msecs_to_jiffies(DMA_TIMEOUT_MS));
> +	time_left = wait_for_completion_timeout(&priv->dma_done,
> +						msecs_to_jiffies(DMA_TIMEOUT_MS));
>   
>   	spin_lock_irqsave(&priv->dma_lock, flags);
>   	zynq_fpga_set_irq(priv, 0);
> @@ -452,7 +452,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>   
>   	if (priv->cur_sg ||
>   	    !((intr_status & IXR_D_P_DONE_MASK) == IXR_D_P_DONE_MASK)) {
> -		if (timeout == 0)
> +		if (time_left == 0)
>   			why = "DMA timed out";
>   		else
>   			why = "DMA did not complete";

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

