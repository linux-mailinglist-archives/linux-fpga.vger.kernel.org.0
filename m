Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96CC3B59EC
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhF1HpC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 03:45:02 -0400
Received: from mail-eopbgr00095.outbound.protection.outlook.com ([40.107.0.95]:13393
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232417AbhF1HpA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 03:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZooULy4aS4PAU79b/lZ/xKQIcbCSsWSFZ/RirohxZYhcV5AOLVHwLpxMxJsrs7mDAhMxm9v/EkWwG4eSuxJWvbWNBMB9H/EXNU0vnhS2uFog9jGdsvSGlB5tvat2Cu79q7O9tjgnozh4xljP/sG7K15FdggRoNIscCQON3v/wLeO4KeVt2aSqf3fswgSzs0yL+Mzd9q+RDPPoOxWe31ktczHSqG5Io2atREMBvPdvP/7ZgqVMKJbrF31COtrb12V6LMti3hHqcMksL2bpS7OAW2QW3iVIAQ1p3ATMki6si0MdwYzrhbVUdKs+H74Q3NzVBZ/PliDduYT94mT7ZUTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FdfCgXac0wQoswGtQexDtcgHZ+2DQKedOByekJQQVE=;
 b=h+yAkDiDZWBjnj1Hoz2mIpFyG5NwURA8b5Iq9GFa51bhep5TklkPdWcSW2bIISQdeZNC++i4SZTNqTUJDArVXUUw16y8r/VmDyv4i6R3uePirrP6AxFPKDacOsgAkkPgBJKg8OWxeBdSrgJxTCAgwbIbfvyn22xyEbU6FDiEiLMzgc0l3aY7V8/BLvXCBKAudwiCUKtzeGaWFH5hY2gxDVgenpr4sw2k80ywuImaRYlZa57D1+uGW9FPyPfo4/eQZrxqbcSmzk34cO1/FzYQlqgoSa3pD5GBmhaA6dEVVHMvVhbPc4YHtlWZiE1brS5Hot0SGMreZizZzfhvhHxnvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FdfCgXac0wQoswGtQexDtcgHZ+2DQKedOByekJQQVE=;
 b=pHiBuurq2GvSXkyiEHYa60Wnhlr077er2kkaXGcqs7EL6wsZd4dVq3LHQCUypwgtFCJjPGGhCvWZpmIjjaoSBroLk2rPAMNH6AzHzv82HSgBD0GN+wWZfaKCmxa9BY7yZX5PpSKKSbJFRmruTPqZE+KEkryGHqBqTfY8/jeoYVU=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB6881.eurprd04.prod.outlook.com
 (2603:10a6:208:18b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 07:42:31 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::50fd:f133:3592:292e%7]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 07:42:31 +0000
Subject: Re: [PATCH v5 3/4] fpga: pass fpga_manager_update_ops to the
 fpga_manager_write functions
To:     trix@redhat.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210625195849.837976-1-trix@redhat.com>
 <20210625195849.837976-5-trix@redhat.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <f80e3d42-31dc-d9eb-90ec-8e740e2e4237@silicom.dk>
Date:   Mon, 28 Jun 2021 09:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625195849.837976-5-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM6PR08CA0039.eurprd08.prod.outlook.com
 (2603:10a6:20b:c0::27) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM6PR08CA0039.eurprd08.prod.outlook.com (2603:10a6:20b:c0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 07:42:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d9b7ed5-9816-4a43-9849-08d93a084933
X-MS-TrafficTypeDiagnostic: AM0PR04MB6881:
X-Microsoft-Antispam-PRVS: <AM0PR04MB68815FB8F9D7A87D111A0EC9D5039@AM0PR04MB6881.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMP6cqrwq0EUb0PZ1JWMOZUczFesV0V6H4T89RmHOWG5jy9+PMZvlBLmWpTa0besPM0T9Sl+f8+p2iih9AKL2qT9Agrb/9D0HqnJCXsGMXkzdWH6feYP2IVHP8Wli/vFzawqBFbhDl9iEvQwCe1K9Fg9l98D48p42xdP30T1cQGQ7GUMYe3KeQrmND53VB53EaK3jQFGUwnS2KKDkWMZFZPR2Tz5V95ttGVB9aajUsKMyDko7D5U8LlxGLMl8rH8uAq3sgkVDjEi5K/G0IhB8N0NB8KGEBrP2o7JG3Yzn3KqFjX+k5CQv/9eK6xG0EPSTUWcinPNwSe7utUYpNJx4DNs2Dilm/foPZhbM9JLgQDcM2yHgmnDMRl3LEGkWpFWh1agehpJn4ftQbYCj9CRjywwEapl7XPDxtmJaDz6AXlZfKJcAoUj5UcDtc1k3QHpBUT41gKdhdanhWknCA6ffx0B/h0wnxmK24oV96Q3ZjA+n/i7uyqEL+XGgIHAZU1noOfcqOa6vGMZ89+N5zGP9KezxWs6Wg8uoAcLo5U9JAqlAzamSKkfGmemMU414ofRmix9buB9obiDLL5sqp498LRFt8XYJVXSZnkKERpnvAZ5DQF9yKmrBjHMx2bqq71rHSFS6KF+5Eu41Wu3Nm4MZX9yMPnpjSTE4dOuCGH84gsEKLNt1ojMcA9TV9RZLVcpVIdEzpmdRQmz/cwDNDZLzAlOGlgfgqLphpm4UNhtqw1jFHWuS6N9JGeMcMFNokiw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(376002)(366004)(136003)(396003)(2616005)(316002)(8936002)(4326008)(66556008)(36756003)(66476007)(16576012)(8976002)(83380400001)(38100700002)(66946007)(956004)(186003)(6486002)(8676002)(31686004)(26005)(31696002)(5660300002)(2906002)(16526019)(478600001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUs2RVlxdVZnMUVjUEw4L2o1S2MyQzc0TmZRVFBYTXRTLzNFVnV3dEVEa29Z?=
 =?utf-8?B?Rm1mN0IvRTY5SmMvbUkvdXAvaDRPSTNLa08zUlEyMFRIcHQrUkl1KyttRVFr?=
 =?utf-8?B?azdLOG9rZFJNVnFIMG5iUmIyL0lSZ0p0aUV5RjM1TnFuTUFMMDAwYUJhamZO?=
 =?utf-8?B?bS93VUFsUkFWVk82TnoycG81aklualcvTXczbnVrQVFBN0VaWEc1S2JiWFJJ?=
 =?utf-8?B?bEZpNDNHaFZrb0FjbnoxNmsrQ0ptbmsrUkY0Vnpmc2hZN3lORnZXcnA3NU12?=
 =?utf-8?B?OEpaVHZoUnFLVzJjSjc5enRKY2xNL2twc1JESFdHeUtSQUJTemFLM1pPdXFi?=
 =?utf-8?B?aHdBR2lKM1JiaVhub1lSd0UrUVhCSjdXeXZmQk1XZE9RU0hFQ0N4T3gxMWdD?=
 =?utf-8?B?V29XQ2lFSnRTRFIyYlNQWUZqTmJxUi9uL08wN0s4aFFZS1E5Ymp4M2xUYmVa?=
 =?utf-8?B?V2RTbk41aVZ1ZXdaZTlNSzBXeE04UmxPYTV5enY1TGxGUHZjaFVZVGNmL0dx?=
 =?utf-8?B?TUZlT21QQ2w4YWNMRHZJSWZaTnM0SVFKRytvY3p4WUNWaGN1REx5YU01azhu?=
 =?utf-8?B?RTJIdnRBalhlUUZTRlJCNHhyUlVWOWh2V0xxak1GYllJN1VuQkpOTlYrTEp4?=
 =?utf-8?B?eGhGbFdZbEc5eURVSEE3emhVT2Rpb3E3aHNhZDdIcE1zUXBMbkpoS3EzOUxU?=
 =?utf-8?B?ZzlkOGR1NWp2a3RuaHNJMTlQRjdnR281TmxmSXZhUy80NUI1azFqaHJnMWZz?=
 =?utf-8?B?d0tFYWMxeG4yVnlZaCtCMXVpeE14cVA3UHRCRXg5cU95NG9GcFZMenViY3hl?=
 =?utf-8?B?ZW5SU0xiMFUvYTZvZTVFSmNBRG5hbDNGN1lnZXFLZEJsb3dIaE4xb25LTFVQ?=
 =?utf-8?B?c0FEUW54VmRJWmRJZDdFSWdJWHYzOFdpNWVXaXlrek1zQzBVK01lSytXRnpp?=
 =?utf-8?B?ZWR4eVVTZm9SWkpVdy9GdVFEeHFXZUZTRTVTcnVDUS93cnNsRHZxOSs5bDdn?=
 =?utf-8?B?Z21IVW12ZlA4bkFERDlZMTUwNHB1Ti85U3RjemNpZkVyM2xIaisxY29KTllS?=
 =?utf-8?B?a0RZeG9EMTBxYklPMmpKbURlSEJ5TENOM3BrRktTeG96eFRMNjFOOVBwcmlz?=
 =?utf-8?B?a0E0em9LUCtScjlOeHJuOVFQcVQyVkJKTThodU51M09MR3NUUVpraW92VG81?=
 =?utf-8?B?dURWVG80SnU3Y2ZuOS9qcnVJbHg2bVBZanMxaGV0Q1MzYlFrdjhKdTY1Wjdn?=
 =?utf-8?B?WjQ2aDl6bUo5N3ZhQ2ZrL2lseHdxYkkwQ3IyQ0NKa2gyU0V3azlMVU9sNUpL?=
 =?utf-8?B?WVNiMkZ6UWtLUFZCUGp6S3R0MHdjNVFFb256QTBOZ1NhRXZBWCtETXpKcG91?=
 =?utf-8?B?eXhrakVrRW1HTlB6eTJkYkQ2aURXUFRNVXRFd3NZclFlVzU2SnFvcHVFNnBj?=
 =?utf-8?B?dTZvTnpDcm9YM2ZXN1E2VHNqVEVvWnVwTmpOdXZEMkNMSXJIQ2tTM1RFUUtt?=
 =?utf-8?B?T1BVd05FZUZHTEI0VTVHaXpkeGtiV0RDOW83TS9GUzFQdmZ0WWozeU8rZFVt?=
 =?utf-8?B?UFNRTVh0QmJsMFAwOFdsVVFTOHNsWVNjZ1dqQ09oZ0Nta2RSRnBlZEo3WG9z?=
 =?utf-8?B?U1lMblp5alpGUGV3ekN2QVVLaTFUSlJLeTA1UzdZdlZuRUxvT25IcUVzbG5X?=
 =?utf-8?B?U0NocmlFQ2RId0dnenRQRDlNT0MrSzhxTkEwc2VDa3hrWnh6NUVQc2d4N0o5?=
 =?utf-8?Q?XFEsu74ErUeiYSsRNBMnBraFmqzlyBhvAN20iTD?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d9b7ed5-9816-4a43-9849-08d93a084933
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 07:42:31.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjxiMjr/6F6qoBnp9dhU1t4L91nHTihJE4wEmftMEsH5vgp8qQxZCWIckTsM5cSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6881
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 25/06/2021 21.58, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Refactor fpga_manager_write* functions for reimaging, pass
> the update_ops as a parameter.  Continue the passing of the update_ops
> to the write wrapper functions.  Only do the reconfig ops.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/fpga/fpga-mgr.c | 90 ++++++++++++++++++++++++-----------------
>   1 file changed, 53 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index 31c51d7e07cc8..c8a6bfa037933 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -45,10 +45,12 @@ static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
>   	return 0;
>   }
>   
> -static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +static inline int fpga_mgr_write(struct fpga_manager *mgr,
> +				 const char *buf, size_t count,
> +				 const struct fpga_manager_update_ops *uops)
>   {
>   	if (mgr->mops->reconfig.write)

Shouldn't this check be

if (uops->write)
	return ...

?

> -		return  mgr->mops->reconfig.write(mgr, buf, count);
> +		return  uops->write(mgr, buf, count);
>   	return -EOPNOTSUPP;
>   }
>   

<snip>

> @@ -208,6 +215,7 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
>    * @mgr:	fpga manager
>    * @info:	fpga image specific information
>    * @sgt:	scatterlist table
> + * @uops:       which update ops to use

Tabs vs. spaces.

>    *
>    * Step the low level fpga manager through the device-specific steps of getting
>    * an FPGA ready to be configured, writing the image to it, then doing whatever

<snip>

> @@ -285,6 +295,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
>    * @info:	fpga image info
>    * @buf:	buffer contain fpga image
>    * @count:	byte count of buf
> + * @uops:       which update ops to use

Tabs vs. spaces.

>    *
>    * Step the low level fpga manager through the device-specific steps of getting
>    * an FPGA ready to be configured, writing the image to it, then doing whatever

<snip>

> @@ -356,6 +368,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
>    * @mgr:	fpga manager
>    * @info:	fpga image specific information
>    * @image_name:	name of image file on the firmware search path
> + * @uops:       which update ops to use

Tabs vs. spaces.

>    *
>    * Request an FPGA image using the firmware class, then write out to the FPGA.
>    * Update the state before each step to provide info on what step failed if


// Martin
