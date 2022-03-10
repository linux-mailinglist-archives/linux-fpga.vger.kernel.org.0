Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370694D51BF
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Mar 2022 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiCJTet (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Mar 2022 14:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343630AbiCJTep (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Mar 2022 14:34:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41201151C65
        for <linux-fpga@vger.kernel.org>; Thu, 10 Mar 2022 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646940816; x=1678476816;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/hLAmkjyyxO2TJLYttmYDW3WmMPt6DDFvK0LxrNkQUQ=;
  b=KEI+sIQzN5cGTA7Kuo+VZyB/3L/C6MlUtoFab67IDf1c9pa3mjiV3A9U
   cx2QwYgnIB0r1ho7EflKrpFbOeZhURJuCLlIijk4dAC1q2Aw+zcOxATYW
   ooJu4Obwz9FO8Be8+rO9r3LXvyfF/JjTlUGSGwPibQEkOoDPFWH2a0YnB
   01tJ8Dfnc4eYZl+La0EBNkW+2edoEKPBafGxK46RdEa055TCPrZvXabmx
   n/5gq/pFwIomkKqcAgz93ld11jRIh9FEsazN/1foV2EVcwolGx44HEJtO
   Dio4NFrEhFPq8TwJ5KLnsLQHXKtgJ1WdmtfC1RBVJ3K8JEFEwPPPDr4Pp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237529156"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237529156"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 11:33:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="712506625"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2022 11:33:14 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 11:33:14 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 11:33:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 11:33:13 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 11:33:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdAonj2s8gqynWIdHFMBVuYAU7OukyHnYj5reHlDtrwVju6/JgwUws+o7KrFh7sbDXcxpQjtgZUcSB0f4ha1jCbo1vmW1scngVfE31G+kVDuwN3waYN7446+G20Pf0fjbjxLwxmjTxPcjWWteeEh+m+qp5PJ3ZYkpcpR/VRU3DXKTca437l5S3pWqiGWYbbofeCVaY7xOb3zBxBhxdWE8m8Nj9YNNrIZjbht12+xjYaZMqj4F9y8NvR4BZppqZ2O/L9SNsoRcX6FUu2xuwe/S5L5oM2ph5CvLzaQagqdKhyTMgVArEIhX7gaV+BhKWcUrehEACehBMZa+LhgF7zL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUJTuVrCjPvAYKlf/+fcWATvP5c460EFHk1xhGHwhCc=;
 b=ZGqOsx6UofPHXgmlsBboLDvPNQDkx0fZ3stLZWYnqjQHLurM5u+D+zv5zvIItHW6kCfminaZ3w454PDpLRilcEaNdzOssEv3nKyh4u68EyEMuOZpF1BD1hhZBz6Xzm5sNgsHbptI8ypcazcGTZ/jCym36tnUkMKpRFOm2+e6lE5g0sXWElVYOKxfimh+jTv3hGjQyeYZlksSLUKLmzyvdQRkrgwEbV5iuWL2aJL+zMpZBAqvluf/rfHnBAMXuA5qp8IK+ZrKIiGL+SlcwJc4kS8/jLbWnEdDNgPc3dqwcUFQBegzEho72JJLytdaP4fTt1n3LcSehWyMSsBnr9XIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB4377.namprd11.prod.outlook.com (2603:10b6:5:1dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 19:33:08 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d%12]) with mapi id 15.20.5038.027; Thu, 10 Mar
 2022 19:33:08 +0000
Message-ID: <03814133-4bb5-f8df-ed2a-fa94720c3075@intel.com>
Date:   Thu, 10 Mar 2022 11:33:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v1] uio: dfl: add HSSI feature id
Content-Language: en-US
To:     Tianfei Zhang <tianfei.zhang@intel.com>, <hao.wu@intel.com>,
        <trix@redhat.com>, <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <yilun.xu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220308064315.1452217-1-tianfei.zhang@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220308064315.1452217-1-tianfei.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:102:1::41) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 687b4571-e8ae-46d4-a063-08da02cccdd8
X-MS-TrafficTypeDiagnostic: DM6PR11MB4377:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4377978165285F5632F19B8AC50B9@DM6PR11MB4377.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wTDd2P+dvsuwoMpNdpJwDeLyCp9k/qkmrvn7hXGNlFXJ5r0jJeLFGz1NhDfSFGxtYGEtJNH5Lht+erUYHKDuLyq2SJlTWelZbjl3rMzHEElc93fCmXSCXwXudDMrieHNwfWz/8GtjNsWq8/8We6jlKiH2g1PgloCrHtwc5mdJGKCzMpDNXY7DNP5g3KoBQ9kOI9Pet2IxpxIdJ6XL2jO67z9nIssj9Ix7MshFiYPqqYJIJeslxNlQezsEqkBny4pBcdykP49PkU11XjQxRqdO1ZZbp0tkyCQ4Rq5Dr6LBz9UMzS4tbV/kY8kDUuAXanIZPrrBTdFxHYnnAPBPxJDgOtVom6YrTNI883gfZK0JyDzvq52PZZ0kyWP5oWVfGj7lF0vjZzOD4ayKs8UkY3WVF4OqquwwO8F/Jf7gTcR0c+2oCa5dfLIrfBL825acWGdc8fENN+1+0EPZw7sctNENFjelW7UFjR0V9Q4eFuAd3GOtW4uRewUQNQM5V6ppPDY+JaQBVghClsTSq97UZVBa+EG/SgaZ+dpVjmdOPRlju16LztYsz2cv0y/sM+0PSKE+ZLKkQiZnrFBqxIEmcllSOfsTH6g8YStio0wVKGBHy3EyFPcTp/Jvt7L5QsOGN4wPiz3oHzh+vsn64Z5Guz7JNhiN6HYi0hXsd5PjOEbDO2sLieeyJBwZmmjCJBUGEV+C4LkVQf0EjV/ZQTwTVdzpDkotQhTrjg0R5PvBR3hEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4744005)(31686004)(6666004)(2616005)(316002)(508600001)(8936002)(53546011)(36756003)(6506007)(38100700002)(82960400001)(8676002)(2906002)(86362001)(31696002)(6486002)(4326008)(186003)(26005)(6512007)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXU4NWlZTnYxTVlEbysyOThUQUtRTzNXdzFHU1lUbWxybE1ZUGtVNWp4OWhs?=
 =?utf-8?B?V0pBQXBXeDNXUTlXa1ZKUFN1YmpCR0prK2NCbHJ5S29RTlAydkYvUXZzTnA2?=
 =?utf-8?B?SGhWWFFVd2k5aXhnQ0hoUTVTYU9KK1k4TWprUm5taHlBc2NFZG1xdERjUit2?=
 =?utf-8?B?WVZjWFMvN1NDcCs5T1B1aDh3cmJqb2o3cFhtRE5hdHpaaEV4UWNIS0VWV3Ro?=
 =?utf-8?B?c2dPNFhIUHZOVUh3ZGZVV2JHeG9BTG1KSnRZdGt2WGUxSkxnK2xlblZsZ2kz?=
 =?utf-8?B?dEJXTnBjTFVrZGJBMEtOWjFMSG5UR2w5YnIwcFJ1Ty9KSzY1WFZqTU5zalph?=
 =?utf-8?B?S1IwSHNQNzBwVTdzYjB2STZmUVloQTV1akxmMEh5UElnNFJ1RnVaSW1aUWMz?=
 =?utf-8?B?dHZrcEhDaUc5SmMrZU9kaEZEdklKcThiWjAxVWpVRko3RlVVY3M3UE5vNlFI?=
 =?utf-8?B?QUtFZC9WTUM1Tytmd2dwZ1ZEWGw0NktLRTRmOUxlYUtzNzRiR3VJbVYwbmpQ?=
 =?utf-8?B?YlZyTDZKa2I1ZUtVZnFMK3ozLzk0ZlBoaXdiK1dJZGlkVGNZcDNGM1B1Q0Jw?=
 =?utf-8?B?T2owdTlyaURIMXgxT0RyNWpWZUhuNDh2N1c1MndIcXkvM2tBTVhteCs4U1B4?=
 =?utf-8?B?R1lObnZmQlVhTjh5YnNKd3hHdGxSVzlxQ1VuOU5ENnlRYUFDT1JGRXhHNzVr?=
 =?utf-8?B?UVhxVFE0QkZidlB6MGlLRWREbWgwUTIwTWF1MmxrSmtuN0F6QlV0Q3JjV3BT?=
 =?utf-8?B?b2RVbGpTNVgwMkpoN1R6VWFDRnQ5QkwvaG40UTlaUmwza2QwWWh6TkE3c3Z4?=
 =?utf-8?B?L1F4UDlGL1poMGF3OWt6MVhNd2RrSVNROFJZSzgxd1lSUTY0TDJIZjRZcWkz?=
 =?utf-8?B?cWJLTWVLN1E3Uk5IUy9jc2ZlWmxadUR0ckJyNTdocEowTHVIVXJ6MHNWbEZv?=
 =?utf-8?B?MnhyTTM0aUFsdmNFR1dDOWtaOXl5S1l5NS9HV3JpamNuWU55VXcycHVvdk1Z?=
 =?utf-8?B?SlZaV3BVNEdxUXYxemVxVStvVVdOMVl0V1ZHMHFVSUd4cDdWMnd0RXFkYmtp?=
 =?utf-8?B?QnZLN2tDTVFxYXhIcmVTYUFGcmI5R0F6MmptUEg0ODVqUTZyeHFMZUZzWk1q?=
 =?utf-8?B?SUIxT0FON3hhWUhNZncyU0FTTHh1emRVMlpuWGFwMXI0b0ZTYnBUNHF4MFdI?=
 =?utf-8?B?MHorRThxTzFSbHUwa3pvd2tXU1NWL3d5eW9uOHVxcDVJMVQ2Z1Qxc3RYeTI1?=
 =?utf-8?B?OXB1UkhkRy9JU0dEYk9VejhpamJZS2QrTDJtRWQ3QTVrUWRQcmhhc3hVdjNP?=
 =?utf-8?B?MDRKZ090SDNleUVOR0pVNlQyclRVN1A0bFQvVEdaTkhVSWFmQmtZK28wWHJN?=
 =?utf-8?B?eGEyNXArcktUMmtLOHJ6cXQ4ZzRYVDJ1NVJkTWg5OXkzaEVySk0vSDBTWmd1?=
 =?utf-8?B?T2I2bTBCQXBQVHB4YlF0VGlkUFR3ekRydlBnWGlrMjA2S3RQbStTZE9XYzlX?=
 =?utf-8?B?TzJpdU1vdEpSc2h1YzFXUXJ2YU9tK3E1bUpoaXhINjZOcEZhejlyVnJnaTlW?=
 =?utf-8?B?RnhvUGpGMzJoa0xNaVVEUlFHL3RqQU5rUFdrVDNsVCsvR2E1Y2M3YmwwUU9l?=
 =?utf-8?B?Tk5kcG4wNVhSNFphY092UHpsUDNBRmdWdU5iQ280bGozaCs4TE11L3RRL0w4?=
 =?utf-8?B?YStEWkRWcjRiTkR2NkJsWGlPNVpTUzMzQ25qd1VISzhHWjhUSkR3bTZuUTgw?=
 =?utf-8?B?aEZQYis4c29LVndtdE56aXhUT3ptNnlVU05PNEZPZ3NHRWJiK1hSWGxjbzV6?=
 =?utf-8?B?Sm1zZUo3TjhKb2RPbFpRRTRoTWlaTFVsNTVDSXBZdnBsZUM3MFFWUnI0Rk5E?=
 =?utf-8?B?Si95a1A1YUZJdUkyN3FJWFRPTDl4WHQybzBxL3RDQnAycEJKUSsrM2JMNytP?=
 =?utf-8?B?MGhmYXhFMklsVU5UY0RSdVlxOVNjM0xGTWdpUDFMMEFiYm1TaXhuVVlOR1JK?=
 =?utf-8?B?c2E4M01CemROdTUycEU5ZE9NVnduLzJvWGdRTm1aSlF5UEJtb1BrN2kvcXpo?=
 =?utf-8?B?NUxCTXNJUS8xaXJtZ1RqdkRDTTJYa0htbmJYUlRMbzVJMFo2UURCQUlHdGFG?=
 =?utf-8?B?U05VNmtMR1ZkVHhSai9EVVkxOEJKekJ3a1dldGt6T0x1NGdHTlFpVStyM05S?=
 =?utf-8?B?RzhDcS9zU2t5eGJsVEFERndsR25TaExiczByWEhGVnduUUM0ZEVLTVJvVkFo?=
 =?utf-8?B?OTUrY0p0WmJ4cldBbitMNFZtU1R3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b4571-e8ae-46d4-a063-08da02cccdd8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:33:07.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVjd3CRnKYTDUUbNPvWmquc81mSb4O+Z9cbcr1Bi6HPHTWC1yWLgxfTbl3Qnv7htn9O5KPTIV53/uAxXqcPn7kLAzJTQyyikVgfHLSP/DFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4377
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 3/7/22 22:43, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add the feature id of the OFS High Speed Serial Interface
> subsystem to table of ids supported by the uio_dfl driver.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..660e1d0bf6b9 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  }
>  
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_OFS_HSSI		0x15
>  
>  static const struct dfl_device_id uio_dfl_ids[] = {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);

