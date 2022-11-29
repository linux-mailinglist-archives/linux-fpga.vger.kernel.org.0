Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C743363B747
	for <lists+linux-fpga@lfdr.de>; Tue, 29 Nov 2022 02:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbiK2B24 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Nov 2022 20:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiK2B0t (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Nov 2022 20:26:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDA642F54;
        Mon, 28 Nov 2022 17:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669685189; x=1701221189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vkwa75qk0IGJ475DENXzIxdxJfL/hyw55XQbmotxHlY=;
  b=cUUK7LtMIGTUhkHUj20jw/5lMfOQtfQ/x+qfuKE9wOEK+8uBISSaj9Y3
   kUxG7MJ7i4YmXa0BtClddGpJk/hTS5xQYQ8N4Du8hUVh/3x6lUO2msq5Z
   imudUy6cnxEsw1JbU3sixPtda+MR36loo6luXDcYhE1W2PAVIETjkFR6V
   mT7rMrj6FuFH4XMEXjs09nEh0meEBoFC5BUI264geWk5NqHn3lmUTNo0Z
   OFlEbwILzNlqYG93TbkrU7J1SHjR1SgIP8rkVRshNiagCXfKT6qgjxioB
   tMclH2u+17mbsKapofsv4oQ+FNzs/MnjVj3gLeQ80+phpJ4+slPidRTkp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="401280037"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="401280037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 17:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="643606681"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="643606681"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2022 17:26:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 17:26:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 17:26:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 17:26:27 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 17:26:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmcHdqwgqSGaf6+YGI/t1RfAeB1HtW+YNrGuY2sHHVXCfxApDqwdTC8LFv5+bfTUcIoeJnLtRFSuZwDt88AqjSSNx0fJeMMqKviY6Q1EwqczaxuUl8Z0ylZQiht6SZcrSDBk1XzCoFRHhGwP7V/mOk7EHRwboyApuTq3EB8xcyP6Aof3sayuaCsC/8FYNSWauxfMX6bRuZTDbl1/DaWQD3wtr1ebVGfsbo5GELKGTV3gINlUuaLAnjsqionErhJhQqWMS02GLBT5DplJqJ4lNisfLMmGg4tTqCl9PT7H6W9mF4uwHZTEPz9NjevXX2A6qV1qkebyJhf//lzkVxeMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1aZM6Ll8q44dTrNwt0aYbt6vXaDgnPH+PCKlu/WvnE=;
 b=nMh0iTOSPgVKdb3wwqT9/zCf8wMVOJuKl1kdvZeAKACuzhYTAI8vO5KpDXCwLFkRQ2KEP9lv7F6EXquB7wDSkqTW8OgUVu5fqVPEm5UUR+LXedorboNHr6KcFhderNJGZkNn9JAaigQniPOp4tvTHe8GOAL8zcXorjaiaYw6vBnxW3dmCH1R1cWJprT44P8DstxSFmOmsrt63xaKeQpMS8uIHuDVFj2gsCWkNBQgk3a9HID1w79PkzCbE50P7qPf++A3Uc1gb1p5b+cah6MEigugGzUJsgHIsvXzJ3MYV/X3hNC6oQglGxn6fNuUPEEaGO7wk5KTD7VRTLSRcrlYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.6; Tue, 29 Nov
 2022 01:26:26 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 01:26:26 +0000
Message-ID: <bdb1a752-ed47-1f9f-8a71-7b85e80bd547@intel.com>
Date:   Mon, 28 Nov 2022 17:26:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] fpga: stratix10-soc: Fix return value check in
 s10_ops_write_init()
Content-Language: en-US
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, <mdf@kernel.org>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>
References: <20221126071430.19540-1-zhengyongjun3@huawei.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20221126071430.19540-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0319.namprd03.prod.outlook.com
 (2603:10b6:303:dd::24) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|CH3PR11MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9643cb-eff2-4b04-4342-08dad1a8bb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD1BfMo+5KFGWjE+AFwyx3PQoQ7cL8zVa/FOt/zpJHWBP+4my3ddTYoQXwE5XE0/DkyGm0N7zagMU/CFYWAfKQGNZZSmxicfOxcSJ96uvku03YCjy+uXC2sXXPjaIdlI+BIlQbMXq/9JMMD3zK8ese8aRQcYk/RpjY716r8kwLWPj6emkHEeAfo8FD6VIzLpSu0LN+3Rm8aeFg9TeaKPD9cZGbSOOA+NczRleqKD93Ke414gsGei47zYNcePHF/hwwgG+TZzxBMQCK8vrYtdWad4FHuM1Dbf1egy4hSRY35TehoBf+v18E+oHeuASzmw3ui7ZWCtqVdymBQhBDPkzpH/CJy0l4CefnZh7u+WmosY4Y58wSQ02GlmAenu3fs8VT7ZxxabOG8IYq9jgXO//3TCO6ylmS9fy76dXmWGyOpTHKpv7bwvF5yRyinpyr7/oHn6pKsMvmmJ1LQ/kS19xVFCs0adiohg88TUwetKIXGUbUtl39hB3WXdbc4+QGm/YQZUXgeuhzZKRgxT8m+WTNpPN86d73BjyMKt6mIzD5CgqL3VtI6x0j2rWGiSmXIfQ5KVX0+OfENORq17SUjnNd30t0icxFSKdsnKm/zUOs+V695w9JrQ8waJRvkISCs95UbdKnq0R36jZDnSQ28+/gksqmNhH+N5/tRH3sN9Om0G9Nv7CIJ9jUgyykZa04UBjBiI8JqBHiqiuxtBgFG4OZsuMdH9+ynnxlN4JxTA078=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(186003)(26005)(6512007)(2616005)(6506007)(53546011)(478600001)(6486002)(36756003)(6666004)(82960400001)(86362001)(31696002)(83380400001)(38100700002)(31686004)(2906002)(66556008)(66476007)(4326008)(8676002)(66946007)(41300700001)(8936002)(316002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2pLRmN5S1BaUGRrS1p2dit1akc1UGZXQk1SQnBsckY1YjBrMG9RZk9HTEc5?=
 =?utf-8?B?ZXJWZWpIcVlVWFBKb0NPaTUxcEhVbENXbTZCVnBxSlNSbm02cWMrajdCd1hD?=
 =?utf-8?B?MDNpdmN6N3ZKTnNuNDRkT3NZYXMveWhKWkF3VGpMM3RCc3A2Y01JUlA3Nkhv?=
 =?utf-8?B?NmxzRUxIb0hrbnFFNm9tczZ3RUZuOUcyVFdWdGU2WitmL3RNR09YUC9zSHZt?=
 =?utf-8?B?T2J2eUdDbXhDckF6MVlSTm41QUJ3c3BIRmd3QVkybjNMK1oybitTUEpyMDdr?=
 =?utf-8?B?THlKZmMrYmhVbUpxS3dqNHVYMnU5c29KV2Z0TlBXeERkMTFzZGFacjRUNE1o?=
 =?utf-8?B?ODhEUUpRdy95eFlOUy9BOXhNZ09RRmsrZzBoYjNPMTBPNnZiU1BCRjZiRVVS?=
 =?utf-8?B?cWZkSXd2VzlzMm13ZzFmOGh5SE1BbUVubDRxODhrK2NLZW45S041U1VNbnpI?=
 =?utf-8?B?UVUxR3JJYS9LT2V0Y3ZLcVBGbzdMYmZuWFo5eUhRTGdlZUszUUVLUk9OSjJw?=
 =?utf-8?B?UkdOcG5BWFUrNkJMdVF6NWR5RTM3bXhySDZOWlZVRzQ3V1dkWGgyU3lJc1Q4?=
 =?utf-8?B?WER4dldCMjJpSzhOdndzMkhociszY05xU1ZGeXVLdW1Kekx0SWNVL3ZqRk5B?=
 =?utf-8?B?clBGdng4NTU1YmJFWkJyYkZudE9RZEJnSmlUZndsN1dReEtBbkIyT05jc2ds?=
 =?utf-8?B?U2crSVFVWTlBaFBLSDhxbFV2K2c3TlEvY1B6WlBKcnBYWDdOTmlkbzMyU29s?=
 =?utf-8?B?Sy9KSzNMQmVPM0NCRTFEek5NS0g4eUh1ZmJPbnF3K1hGOWw4Zm84TVlWWkJL?=
 =?utf-8?B?QXF5NFQwSTdrRklUU3NlVm1yUDU2dVlmMU5TNDB2S3FGTCtIMnk4QmFXN09N?=
 =?utf-8?B?V3p0WXo3SGt2YThlMWNhNUg3amw0MWFvZXZDMVZaTlNCNkREcXA4N0g5eFd1?=
 =?utf-8?B?YWd3WXBJSUY4WG5LRW9OMEt5V09Uc0xjc2dvM0RHTjZZaDRVR1k1eGxjYitj?=
 =?utf-8?B?czl4Z0NrbU10d3p6djdaNStLY05PWFRyVm5zSXU2WlF3YkJLS2VNNzQxSmlk?=
 =?utf-8?B?dE1IaXFXNjB2YVUvbFFtZm1yeFF2TE1NOVZacjh3VFZDUDJEVnh2emhDdW95?=
 =?utf-8?B?dkRkcmFrYUtUVVRLekhBamVnSXNxRzQ4NnRONUVnVU5MbEExYUVXcUNMQ2p6?=
 =?utf-8?B?eE5tZXNMVklESlc3ZVdDNEFoUmZXT25VTFQ1KzBBR0x4UzJUMlRGbSsxaXVv?=
 =?utf-8?B?eXRrYmdnaWFwakZiMEIwdjBmOFpUTFpEU1lsREpxZmZab2pTd1hoOEg2ZWJq?=
 =?utf-8?B?TncxTDlXNkdxV25UT1h6TnNjdGRucW9xMGdKL1ZabFBQUVZhWE5SeWRia1ZZ?=
 =?utf-8?B?Wkd2dHF5Tk9sZFFsd0dxbCsvWVBadjNUQllGd05FWmpGMUo3QWpyUnNJMDBl?=
 =?utf-8?B?RWxsVFZtd2xJSEVxT0Z6K2xsWk4xdURESXhqNkZlN1UxNVoyb2txUEduaGtj?=
 =?utf-8?B?R2IvSlJPbmdVV0RValRRREk0bVprN2trSHFnc2J6NlhqV2lLUDF0ZE1EU1BL?=
 =?utf-8?B?RUxoTzBEOUYzTU0xTlQzMDQzWTR3OHUwQ3RmY3dQeHgxdmlRMXZCTFRIKy9F?=
 =?utf-8?B?QTl4cG93QUlON3IxMFRhRk16alZFRExkR1ZwVzdKb2laV0dFWnlzd1hnS05a?=
 =?utf-8?B?VGdIMnAwbXRib2lrQ0NSYmlqVmMrc01Mc2lzT05rNmQ4TW83b0pSQUl4OURO?=
 =?utf-8?B?THZNNjRJb3VoQ2JWY2E4R2FRZ2FKazB4K242NmRpN1U4b01xaGtkT3czZmIv?=
 =?utf-8?B?SnlkVXlMbzk5c3I2M0txaU5SVmJyS0JUWll6dGs3MjRwVVB3Uk1qak5RMU8v?=
 =?utf-8?B?L1FNMDVLU25oNWJWU3hCeE9xWGNnak4xRTUyZUlXSGR6bytpb2hRT2Z5Rm00?=
 =?utf-8?B?N21oRjh4VVV4SGR4RlJtV2t6Wm94WjRSSzRzMTdKMmdBS3RoV2NZWitmaHNH?=
 =?utf-8?B?MGxEQWFKQnBEYUtMRnF2akJZeHBJTTk0blRIa29rbGVubk5JR3ppTU1XRUNW?=
 =?utf-8?B?Z0tjWm85cnJyY0FYM0NYWUp1SXk1QVJ1cjJNUCs4U01OTVdQMlJHOWpyZWxi?=
 =?utf-8?B?QmhvcmJoaDVxeU05Zk1oRkZ0LzAvNlR4VlgwV1B3RWNydkxSQUwxR1UxZmNw?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9643cb-eff2-4b04-4342-08dad1a8bb7e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 01:26:25.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2eRmV8RC4DKM9xRR7XamWG0wxwViyMSdYOGhQPcZ9vtoiTaE64IKqkCR4Hpy9dmKDfvYicTlJG4C/61jErUtkRHla2vDM8UaDfCIA/Kr2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 11/25/22 23:14, Zheng Yongjun wrote:
> In case of error, the function stratix10_svc_allocate_memory()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
>
> Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/fpga/stratix10-soc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 357cea58ec98..f7f01982a512 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -213,9 +213,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	/* Allocate buffers from the service layer's pool. */
>  	for (i = 0; i < NUM_SVC_BUFS; i++) {
>  		kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
> -		if (!kbuf) {
> +		if (IS_ERR(kbuf)) {
>  			s10_free_buffers(mgr);
> -			ret = -ENOMEM;
> +			ret = PTR_ERR(kbuf);
>  			goto init_done;
>  		}
>
> --
> 2.17.1
>

