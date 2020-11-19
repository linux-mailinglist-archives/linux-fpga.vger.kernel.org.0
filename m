Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695792B8EBE
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Nov 2020 10:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKSJ2i (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Nov 2020 04:28:38 -0500
Received: from mail-eopbgr60109.outbound.protection.outlook.com ([40.107.6.109]:62716
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgKSJ2i (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 19 Nov 2020 04:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2k0OwIQ+i5ZKd4g6qkeM9o5L2LEDa3INVC98In5iLUVvNg18ABEQkGTgeVzwX6O54ovgnZEHxN3BR5dYbiepVK3rdTz9hxU56ZXkCGw8o0BIZjVx9vtXRTEthmAVXybOxASR2djfMwNr7N6BRoFyss8eIHvTfqPRTZh9DQfLbJMC4DjLiGL2kubJfUeqp0kDmEyaVPyvIRGtmgHa8+1qqn7sjHvqCzMHxBI4FCx00ixPxxIU1P5KhCDsfNvnpolgHox/XN1C2JbhdF/ELt6PtCpU/sbODlckEbFj2F20yAAfkzXOai713sUuBrVoDV5fBQbeY+8Ra9mFYpoXJCgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtsYc4jgfrn61P/99X9kamuSq2xgl0vxKm5TFJQYvKk=;
 b=VjQWc1oBCPrliCaq0hTWSBLoEmHK8bSy9+JZEJ58YzDz6yixLlHzRk+75StNcqw3p5En1pG5OBopagay7MLZlMFyQlsUxGb7fxxBVocnlFWdmCgpS6EyfmlNmPH3l+tbDepCslX+8MM9jz+MFXame3ZIHibm1q61NFdrVDDX9SCG26LZ9t1FXg181W2NP+M6XcTmnNqwjwaKDKHVr6di5cgkAd714uIjrwMLiXHODnCX4vsukk3CMGIWGIZoW7K/FbnswwbDW2dkc/67nK7vIuhjpOn4Q7kG+RzP+/RtgKlwCncNOwYyI0QHjmUeSaDPjF3naH+hESQlMbsJme++XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtsYc4jgfrn61P/99X9kamuSq2xgl0vxKm5TFJQYvKk=;
 b=tni/RiwUlfsguZHnjD9OtjPym/Z4fTL9iUvZLmAVkWKZf92EefZ6c/BS0wHmc4YGoN+4NmXufT2WSryr5ETZ2+hIGonvwgEM/hKFoa1aK/fdXVYMqjb1OOvovACYidAmDJcPswQXcFd5Muo7TWJAsWEB6uUzpxsi2s3e/1wKc4A=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB4068.eurprd04.prod.outlook.com
 (2603:10a6:208:62::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 19 Nov
 2020 09:28:34 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::393c:c6ae:5261:3582]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::393c:c6ae:5261:3582%6]) with mapi id 15.20.3499.035; Thu, 19 Nov 2020
 09:28:34 +0000
Subject: Re: [PATCH v6 2/7] fpga: sec-mgr: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-3-russell.h.weight@intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <900b19f2-3fdb-1df1-f811-a56ea9c68de8@silicom.dk>
Date:   Thu, 19 Nov 2020 10:28:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201106010905.11935-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM6PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::41) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM6PR02CA0028.eurprd02.prod.outlook.com (2603:10a6:20b:6e::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Thu, 19 Nov 2020 09:28:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56dc7151-c4b8-4765-ea3e-08d88c6d7cc1
X-MS-TrafficTypeDiagnostic: AM0PR04MB4068:
X-Microsoft-Antispam-PRVS: <AM0PR04MB406866AAF9BA092BEAC0DBF2D5E00@AM0PR04MB4068.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9F/s/8YnUBnlU9eKV6e4P5xzqTHMqCkusQ9Ii1j5eIM8atnF8/gbK/tAOxcKN8969DHfw2kyeXEG+fNIuy1qrYqTsWwvE9OZUfVRlBUlnBkBs6zqSD8Syhfq4aPIMxVoII7L3QaY/slmH1uedJfSLiqsbLDNH7Xf8AV/pGiCidQ1y4UUH6wXKSGowfPoH+gg3izjtA18cAhqc9XGOtClZFEz9PaApk+vT5E8ksKQL2iLFn+2TcnZ+S0I3pKNwpOGYgqgrLlamVOs9Q1Y7AUTcueEhAEsxelqUnWP8GXNFQLoDTyZ3fLAW8IiNYIzoK67T6t38TfmdfFpiLwRXr2+DCBkcnEjSxBEPlwstoer0G2OU48ywa6aw9613UPzWv1b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39850400004)(366004)(136003)(396003)(16576012)(86362001)(83380400001)(8936002)(4326008)(8676002)(31686004)(52116002)(15650500001)(2906002)(8976002)(2616005)(186003)(26005)(6486002)(31696002)(36756003)(956004)(316002)(16526019)(66946007)(478600001)(66556008)(5660300002)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wz4zUvdkcjTrrZV5DjkVL/vRX1/DswjPWaWF4RiU1cmNylapA4ckymPI2TFHB+pPVb+oRaa1pDLNJC/WBgNV9uuOWmHsLl1UPfjhHQd4Iqm3TgcWYtLDi7eBGXW93A8v+btIeKkOpOX8wahYAdovLqZE6ySZOuyh0bIBtku5qaxgFMBrPCRpMkh6VB2uYOy1AL2rm0KzIYrmH/Gh/Z8yb8yfKtkVI7ivWQzjPliHpzEuNvoVwm6fply0Cr9XeQpZvz2pVSACG06k4e2wMdZh1MqwLNF5QQHQYoFNE3FMFUaA2Tny3gMeIXcb/fAPHK004C4OQBuQIYhHGBjjLqMHH0ROzM9W4pM/doFwqZi/2bfYx5MW7T/CYR48M0yebvTHoYDSes+ilXyE228LtX1iHCk0rdQMNZgsWUiW5BHUQSiWvmLa8DiFsQj9FreI9kb1ChJzSuuOroPU2oK2d8FS+fIP4ucZV/QyfQJtZ6zMp7ARtrt6XIYnvZpx+lQ7iwufclbsAsK+L9LgLgY8BsROxVdKnguvO4BfPXPj8ZMUSDUfpVCbFYL5chQTivyGBghmTlXHIu5HcCnSdQTbGT02WvpiLL8+slDB/V9RUlkrTiT+Wfq5zEJIqM2LZw21Igx77xutFV8mgJ7Ujm2J8lu4Kg==
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 56dc7151-c4b8-4765-ea3e-08d88c6d7cc1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 09:28:34.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOTmY6H/66k0gZolbxMrcdjlnGUAqUMsyIulzF3LppYES1fnUB1VMgDOxTQrAYdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4068
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

Just stumbled upon the below when preparing to upstream some Silicom changes

On 06/11/2020 02.09, Russ Weight wrote:

<snip>

> diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
> index f85665b79b9d..e03de72134d6 100644
> --- a/include/linux/fpga/fpga-sec-mgr.h
> +++ b/include/linux/fpga/fpga-sec-mgr.h
> @@ -7,16 +7,57 @@
>   #ifndef _LINUX_FPGA_SEC_MGR_H
>   #define _LINUX_FPGA_SEC_MGR_H
>   
> +#include <linux/completion.h>
>   #include <linux/device.h>
>   #include <linux/mutex.h>
>   #include <linux/types.h>
>   
>   struct fpga_sec_mgr;
>   
> +enum fpga_sec_err {
> +	FPGA_SEC_ERR_NONE,
> +	FPGA_SEC_ERR_HW_ERROR,
> +	FPGA_SEC_ERR_TIMEOUT,
> +	FPGA_SEC_ERR_CANCELED,
> +	FPGA_SEC_ERR_BUSY,
> +	FPGA_SEC_ERR_INVALID_SIZE,
> +	FPGA_SEC_ERR_RW_ERROR,
> +	FPGA_SEC_ERR_WEAROUT,
> +	FPGA_SEC_ERR_FILE_READ,
> +	FPGA_SEC_ERR_MAX
> +};

<snip>

> +
> +/* Update progress codes */
> +enum fpga_sec_prog {
> +	FPGA_SEC_PROG_IDLE,
> +	FPGA_SEC_PROG_READING,
> +	FPGA_SEC_PROG_PREPARING,
> +	FPGA_SEC_PROG_WRITING,
> +	FPGA_SEC_PROG_PROGRAMMING,
> +	FPGA_SEC_PROG_MAX
>   };

Shouldn't this enum and the fpga_sec_err above be indexed starting from 
0, to make comparison with FPGA_SEC_ERR_MAX and

FPGA_SEC_PROG_MAX correct?

// Martin
