Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307B12C5699
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Nov 2020 15:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390054AbgKZOCz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Nov 2020 09:02:55 -0500
Received: from mail-eopbgr80110.outbound.protection.outlook.com ([40.107.8.110]:23425
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389434AbgKZOCy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Nov 2020 09:02:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzV7r+EKmUIfe1xDKFgX0I0ObCYytvJLHhdva0U4Wo1cw3Uq2POUsafrOJTPX1kTuGxTNi1L4+8FHDSs9yn9dmv2pW+PPW9D7BQEtsN0ioANUmILHkiWwUB/OxpfsoZxQnMpUB2E0lyZQ+CFYdxl8jrT75Xwh2x9Xs5Bcf/T3XARcAFsHKFI1GxfQhybsb3yrXzmgCYA37Vp7YKJRqJ3PUOZ3YSXUsclz+aAS8Qs+P80SSCKeCAjV0JkMi+eSHf/p3GuE7QcB4Ac35FNFUpqe1P58hTtZ8JDGZlwQ5zbQ8CZZduAxaXceAVOvmchaMrPFZkVDFoT/N8wyqP1qV/kQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0mVguaJSeyooPy1Xmz6PW0bYnE+qF7j6KRAs6YvNWw=;
 b=E3hBNu1XJPgGT2yyoT89kChHiguoqXCsOsQE1jgylcKJl949XKod/klzJP8CnytyV84QyikiLJrnX94GgO5yWCUSASQGp/HUwLlNorZl0HQY1sXWi3aMp23oh1dU2j4x+dAAzgnA4z1GcTQLNPn0hYQHQF+hrVjBqJD19s5NsuibX/6AbVIAlMXFtdBNkgxv5WTD8nC5UjZc6GRyCpliXpzYy0bNfhrjBUnaLD8Ivoty1eczWumK8j8z/fxSNgu1vBqxsVomHvn4MtFizu0NJth1zE6HSTWJZU5ogXr+9IHweykJtxy3LDwuqu+sJPzdndfJntTt2o8n28q4nfu/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom.dk; dmarc=pass action=none header.from=silicom.dk;
 dkim=pass header.d=silicom.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0mVguaJSeyooPy1Xmz6PW0bYnE+qF7j6KRAs6YvNWw=;
 b=qeinjyFEHZqARsSJTSkvY/V1eGD4MovTU1GZW9tvzjBtqwm80iPz2GLpVUMRsaKSv0XqCVn5WE5smeEh5/x16lvF66pUudccJd681EKCz6iLHJIA+mmcZryUm+m3SVsCChIyrPlhyrrmwvyNK2OzbixtW/ex2zpC1b3SQ+5+w+w=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=silicom.dk;
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15) by AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 26 Nov
 2020 14:02:50 +0000
Received: from AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::bdca:6651:1054:423b]) by AM0PR0402MB3426.eurprd04.prod.outlook.com
 ([fe80::bdca:6651:1054:423b%5]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 14:02:50 +0000
Subject: Re: [PATCH v6 2/7] fpga: sec-mgr: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
References: <20201106010905.11935-1-russell.h.weight@intel.com>
 <20201106010905.11935-3-russell.h.weight@intel.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>
Message-ID: <9dd75daf-eb73-4008-ca65-6f7ea3923e35@silicom.dk>
Date:   Thu, 26 Nov 2020 15:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20201106010905.11935-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.184.138.169]
X-ClientProxiedBy: AM7PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::21) To AM0PR0402MB3426.eurprd04.prod.outlook.com
 (2603:10a6:208:22::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.8.20] (85.184.138.169) by AM7PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:20b:110::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 14:02:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f94449d4-5b49-4d90-0d38-08d89213f5d2
X-MS-TrafficTypeDiagnostic: AM0PR04MB5779:
X-Microsoft-Antispam-PRVS: <AM0PR04MB577988C984EF293354EF7C6BD5F90@AM0PR04MB5779.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQkr1iM5UzW+u8m96XZVOyGycKZ2SBeOlg3ipL/KDCAKNIw09Y5iP5Qd36nwxdu6qoygMc5FoqQ24OIqpfu7vfVNgWA+rT0RhozG7OPiq0SOrrwQh8G8qttWbiRAYquDDaISdFnEtQ1b4FU8hDA5FwzWsASygx+E8UbhH6/aoye5LkgcB8KAsbhSF4xzs07kbwoB8k+kFDjxx+NgpXMvGlCFJf4w7LXurD3m3qtn5LpUF79U9GWMU9UZasTLkdeKaVgdnEAbVadiDbSiY8td4iBM7IBAgexIhlGg5nUe0bDMXc82Gqi4KpgO4c9hS173Gs4ez7sqQh/GLBYGHnUOw4WfOUrssBidkZmq/szkSdw2MPY5QWzHLz0PEhnHUNX1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39850400004)(366004)(376002)(52116002)(8976002)(4326008)(83380400001)(8676002)(2906002)(26005)(8936002)(86362001)(2616005)(956004)(6486002)(31696002)(16576012)(316002)(66556008)(16526019)(36756003)(478600001)(15650500001)(66946007)(66476007)(186003)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?elh2OVY2L1E4UmVoRitBSmxLUmF6MkhVSDJnOVk0YndsQ0RZQk9uMEdCVmhB?=
 =?utf-8?B?ZUJCT2liT084UW9Sa2JGK1oyQld6b0FYVE5UeHFlUmJ0bXlaYlljUlh1S3BD?=
 =?utf-8?B?T1krMGdwOUZWQlU0YXYweENKQzlCbU1OcGFUMy9OclVUSzN3SHZBY2lya1NL?=
 =?utf-8?B?Zy83cExQWi9idm83MktnMDl0K3hlWWdEV1g2S0ttZGtwTno2a2hsTmtpTmQ1?=
 =?utf-8?B?eFVaaWttaUpobVVUR1ZMVldLQ0xGRHpOT0toUXBEeUx4VXRkY1hBQkxZenJT?=
 =?utf-8?B?eFN0ZCtaS2ROOERnb1BhKy8vTmpKWGdGT1ZhMmVWL3ZKZElrdE1YV2FBSTV0?=
 =?utf-8?B?MVA2bXNTZ2NzcTNMYVBaeVo0enBXNWllcitYUTlDcnBoejBqdGFldWFwN2lh?=
 =?utf-8?B?NDlwcnRWNFZybjBuRzAzODlZMlJzeWxYb1FHUmRpK0RtL0RDRUdjRm5PSWpy?=
 =?utf-8?B?eEYvZGFSS3g3bTRJb1daempQcUFTTkZwTVY3Y0tRMzVadVgrU3lSNUMrNGdH?=
 =?utf-8?B?cWVoa3RIT3FnL0hkVjZwOVNFSFFnQlRWUVdYc0RyeE1vUXlXNk1YeS9hWEw3?=
 =?utf-8?B?c0RpK2ZxOWVobjdZOXVsS2NmRGkwNXM2RHUrOE84eDBDUUxYTlJCVEFZSjEy?=
 =?utf-8?B?TGdSTzR1dEFvYzNrVklVVnM2bUE4cG0wUU9oTEg5cXVRcC9yN1F0U3NiRm9h?=
 =?utf-8?B?M0ZoMHJrQUh2amNFZkQrQ0EzQStDWjJGbUpIZ2h2OVJLUWU1RnBiRStQMEdr?=
 =?utf-8?B?TU5ObHUrbTZqR2JzZi9zZmdsRVkvY09QZkxFcjJxbktoYWdzcTR3U1JOQzRC?=
 =?utf-8?B?cnNRUEZ6WTg5c2I4OUxjRXQxQkkyM0JueGpmTnZtMGlISnFINjFieXB6dFdG?=
 =?utf-8?B?OXB3S0J1RlF3UzhkSzhqRlY3TDJ2UHRCQ3pQdlZDT0VxeW5ldTJxbVhid0RK?=
 =?utf-8?B?VExpWmRpMFhVcWh6SGR3aU1CUHp1NjVzWXJ3dkxPLzlJanZxSTlmZ0d4MGZy?=
 =?utf-8?B?cWxiVW1ZVXdKV2JtMmZJR3dTYUVNN0haU2dTOTBla0EwSlFZUlIzcmtmdWh1?=
 =?utf-8?B?bFdFa01PaFlockgvTm1sdDQ5aURoZHpwN2pSeTYyVEdQM2pIeCtBb2xZN3R5?=
 =?utf-8?B?ejVxTWpPTnl2eGFmVlhGbTdxQnJUaTRRSnBqNUxrN2pURlNrVlIzTU9zZVhJ?=
 =?utf-8?B?QlA3WUpKcUM2VTRERXBtUGNIK244OUM3UkU1STBuMDBqbmIwYlF1TitwZldZ?=
 =?utf-8?B?aGVhZG94eXhTSGxRb1RNVHV0eE00Uks4d1cwQXRHOUlxM0svNTdqYnpPMkRy?=
 =?utf-8?Q?+dllRxTnVbFyLGsw2cVCmCHeQ8b99SvS3/?=
X-OriginatorOrg: silicom.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f94449d4-5b49-4d90-0d38-08d89213f5d2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 14:02:50.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1A4T36ds9my4RXqP0htES7+wWoWDrsxq1l23+FqthkOGmqfyhmDRcTVyYPN0DXBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5779
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

I found another thing while testing this...

On 06/11/2020 02.09, Russ Weight wrote:

<snip>

> +static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
> +	int ret = count;
> +
> +	if (count == 0 || count >= PATH_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&smgr->lock);
> +	if (smgr->driver_unload || smgr->progress != FPGA_SEC_PROG_IDLE) {
> +		ret = -EBUSY;
> +		goto unlock_exit;
> +	}
> +
> +	smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);

The `count - 1` is meant to remove a trailing newline, but opae-sdk 
writes the filename without newline, so better do it conditionally...

> +	if (!smgr->filename) {
> +		ret = -ENOMEM;
> +		goto unlock_exit;
> +	}
> +
> +	smgr->err_code = FPGA_SEC_ERR_NONE;
> +	smgr->progress = FPGA_SEC_PROG_READING;
> +	reinit_completion(&smgr->update_done);
> +	schedule_work(&smgr->work);
> +
> +unlock_exit:
> +	mutex_unlock(&smgr->lock);
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(filename);
> +
> +static struct attribute *sec_mgr_update_attrs[] = {
> +	&dev_attr_filename.attr,
> +	NULL,
> +};

Thanks,
Martin
