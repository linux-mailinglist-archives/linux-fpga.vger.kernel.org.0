Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685E407295
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Sep 2021 22:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhIJU33 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 16:29:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:30411 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233384AbhIJU32 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 16:29:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="201358108"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="201358108"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 13:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="505268987"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 10 Sep 2021 13:28:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 13:28:06 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 10 Sep 2021 13:28:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 10 Sep 2021 13:28:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 10 Sep 2021 13:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCjfADlGfbOcVWEM+S9Qmr4pIENEWKW6spnAAkuQvJsf7ZgWDMu+TUt2cswkfCzXkl9KcBUKY0LRkNlwCVPuHzwWph+2pufjM8OR9EffbOzQuZda2pcY3BMyXFA2hK1OrpWWBQZEadlzSv0l9L1XF+9jXdMVQdr5t4qEtdw64R6XSYkUcqSzqBlU4xkVPxytLIjUgVgiiR4MJjhoenBhaD0weH0uapIhAIJ7GvoyfnUQ1Kd0z04aWM3QHkbPhq5r51WwVQ1jWkpW0kEDZ/B73eCeOen95IswMW3SdeuTkWOjHMkeIpg9nYuOyp16jksJrsnUjT9Ds5udtOaMrXd+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=umEKzI7ggXs7qlJ2S4KTBz+qlgaADXYf1Kkc2C38BH8=;
 b=nMrEHFYInG6MV23Evkzq5IPmfzJ/3SImIHoXqSqvhDqaG/jPyFGNnmeuk1uRvAdJ7AY3NXyR4YGJ03TjoQq5WNZ3gswMJFWPxFIblvELpRnEYceeNf5gH2bkJauz72lUE4KdqHkQMO/xhPGf3xRHM1xg0OUKWK+bgQKeaPU/aRq5gHiVE9utY0hk3ybQnqbmqmLc+dXcPzUG6OnsuHllctxBOpEicY8eM8XjA9QYsJxVojnbU9Ov1Ei57rRchqZH6vbaACI0Xb3fptd1c9CcWNk+B62XpvTB5hB5bqlCmSzaOxW70uHepI/13sIXlXKsFXPKXr6QLLs5DZbT18KfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umEKzI7ggXs7qlJ2S4KTBz+qlgaADXYf1Kkc2C38BH8=;
 b=pP4OcWnyB0MWNLW/W/hf98TJYQwCJhdQJVYTxQTs6H4nJ/3/vvGm5KHfvYJvT9yEfRCDgaYmQt5N1we6wbcGD3iWe2qMnbx/Jwnk/4cNnoWTfLNfpxC1b7/EHKGH0o2hlR/m00dKX+7U0CUN78MmvphYXOO80RCeq4J/25NQLoU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 20:28:02 +0000
Received: from SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c]) by SA2PR11MB5163.namprd11.prod.outlook.com
 ([fe80::90de:46c1:4d23:5c8c%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 20:28:02 +0000
Subject: Re: [PATCH v14 1/4] fpga: m10bmc-sec: create max10 bmc secure update
 driver
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mdf@kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>
References: <20210909233304.5650-1-russell.h.weight@intel.com>
 <20210909233304.5650-2-russell.h.weight@intel.com>
 <20210910151335.GB757507@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <1e4a9cc9-4390-1c9d-5ec0-7e9295158dfa@intel.com>
Date:   Fri, 10 Sep 2021 13:27:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <20210910151335.GB757507@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MWHPR14CA0055.namprd14.prod.outlook.com
 (2603:10b6:300:81::17) To SA2PR11MB5163.namprd11.prod.outlook.com
 (2603:10b6:806:113::20)
MIME-Version: 1.0
Received: from [10.0.2.4] (50.43.42.212) by MWHPR14CA0055.namprd14.prod.outlook.com (2603:10b6:300:81::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 20:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97aff768-5396-4935-4065-08d974997d03
X-MS-TrafficTypeDiagnostic: SA2PR11MB4906:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA2PR11MB49061927A31B0F7125D79B54C5D69@SA2PR11MB4906.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r2FT/Z4zGD+uxFbGDU+dxUoU8t5782tBvIX9JBWliokZqSdtG01o3HgjTZ98dWMKvhxrNlYRIHJvk/hzrS+iVX5snxFbAw0UHuWdpnGWWV5WUdFQe/n1e8FYQYxF+9Tp3q9nQ5INGtDeVrKcsvKv7dVmF35NFNbxm+8+xIU/laEbh34Rlj3PCQ6VxjAsIDFUuKm6kid6TyLEhCFUZVZqKcpgR9BXGelFWgHpBohSy9jWCSqCdp3Leeal0/FZoIknFMTszDJkI+ucRJoMirD5LjBxEgdAn1wU4ldCP7U+sEy12FQw2fC/pnrwNulWKrIpTQ51Zs5fYfWqqWWO0/cKqWjZJTqgT+aOiu6RF0DIOTJW7p57WXvuSQ5+5wA0nN7TyGXGGwJ8+wxB/Ny1AO5W16mWrzudR3afl8TkrEA6sfSzyZ1tJRQdFdJUr1j0tNeI6zYzsxPpRojKLVtu8JcL2idks/7XPxyeuwNNYVbi216BHRGwdrblwk07Ukb5qPs7za4apB+C1CP7DNWSSQ7jCklLLpdvxUggh9TemAx4regItnnGV51xEcX5ZALaGJiVi+PoD6DRFCYiE8+sDNbPFm7Y8dsKNRut7eqw35I7cxplThBptXH93zl2CrF5+33rZ9Tc+74IzEoMVItYZcJTAS9z2wa3IMDhl8cikRzgnBD85MwXRBm1Z4SGkr0Sx2wu7VpGR2lixTcrazfIHJqujQ5Smv+IAHUAfif8fZDKUxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5163.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(2616005)(6486002)(956004)(37006003)(30864003)(8936002)(2906002)(31696002)(31686004)(316002)(86362001)(16576012)(508600001)(66476007)(66556008)(83380400001)(8676002)(66946007)(38100700002)(4326008)(53546011)(26005)(107886003)(36756003)(6862004)(6636002)(186003)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFXZ3ZkdzY0ZDA2Z3BYVlhKL1RJN1hBZ2xXWEdHRkFVU1lHVU01NkxmK21r?=
 =?utf-8?B?TDNOcWIyK0VrL0hIMnZsbGptbm9YT3JHTVh1T25QOTVJd0t5am9aQXVQdUtG?=
 =?utf-8?B?UHprODZIOG5ZeW1kZjArc20zVVVHRDI0SHE0ZWxlTGVkNTBHTXpVc1FvUktY?=
 =?utf-8?B?SzVLU2tYT2pWa0Njc3I4V2M4OEJDZUtDSEsrdm9yUm9sZ1pSQTcwdlVDWWRQ?=
 =?utf-8?B?RWcyTk0vcVlzVlgrQXpwdzdNZlAyZUROd0NycHdXcW45VDNUMnFIQ25tQWNl?=
 =?utf-8?B?ZHZYZ21Qc1loVlBIRzBHNkp5ZVhZcVlyWUJWczlXRC9iQy91RGdGWVBIZHgv?=
 =?utf-8?B?Nk1sTFB4NDcxV3duMFZkZWF6eUhDQThCOWNITDJtREJ2dFBnU0pBcXkrWWw3?=
 =?utf-8?B?Tk9kMHRMbWhvOGJIRWlCZFBXcm82Rmp2TTF0SlBJSjl4c2c4b3Nla3ZTU1k1?=
 =?utf-8?B?VUFQOUhFNENmbGpaMXloeU1rWWZhWXVXRFJ3QWlwUFpSOWtuRW1ibldONmN4?=
 =?utf-8?B?aGgxQUVYQytNWkJrdUhPUkdNbFlLR0NNTnNaUEdYSWViOGRJaTZtVmxGbW5C?=
 =?utf-8?B?Zm9JV29Oc000MmZkdG1OV3h1bGRvRElsN2ticVMxcUhpeTJxOUgrMGJBcFov?=
 =?utf-8?B?aFN5NVNzSEZEc0VGWmxEL0ErOXJsbnNaM2x1cWVDK3EyZjlueE1CVEJBbFZF?=
 =?utf-8?B?WXcwQXdJTUdxank2Q1ovb3cxZ3BBNUhQOUpmaW0wbVhtVUZoMmZ0SS9LekJw?=
 =?utf-8?B?cDhzZWJJVXJaTnNleTJCQU1qeUlmYmtGaDBlQzU4eHBZc0lSeUR2c0xTNXNp?=
 =?utf-8?B?K25pTjNzNWt5YXQ2TDRMeEFhT1hjb0ZIUklpaEczUUFsbjBYVXgxZ256dHhW?=
 =?utf-8?B?LzJXNnlJc1VwbDRRZElBVzdaQ2hVbUowblVEdUxYc3RKVGxpL3FIRnlwRS9Q?=
 =?utf-8?B?MjI5bU55LzkwdEJWZGF0WXBMcm5Lb3hxRGlrVU9UcmFHNGZWMk83bmluR0x5?=
 =?utf-8?B?SHU3N1F2c1U3TTdzZlpaTG5IajdvVFY3WVlNdWNXdWZsb2tVdjJ1c011MFBO?=
 =?utf-8?B?aTNUSlMxWmFPMHpzd0wvbk1FdHdlblJGbmRrU3dKUUM5QW9iZGFMNDN3Q3dP?=
 =?utf-8?B?SVNVWTNVc25rRjNaWVNuakZPTTIvMWdLZTM1VzBxQW5VelVUdXh4a3VTcVJa?=
 =?utf-8?B?YXh2TEVoM01HYzVNNUVZWW5QQzNySDNHMU94Qk9xOXl0MFdhaWU0YXhsNFBF?=
 =?utf-8?B?akZ0SXA1Sk9uUEIybkhjZ1JCZ2M5Y21aUlNKeHZ3bXlVYURHSmNIT2k3VG1V?=
 =?utf-8?B?MUIvQXJvVzdGYzdFL0t2K214OVRHRGF3Y1NYRS81ZWZwZlJnVGttMGdEY0Vs?=
 =?utf-8?B?NVd2S3d3ZmR4Mkdvb2tKZWlGbzVKTTB6MVZTWnpoL3puTGdGd2dDQlEra3dO?=
 =?utf-8?B?TVhmODN6S3diMVdpaXlwQk5zclJGRCtCZVBOYnc2SVdQOEF5MVFINHYwSGMy?=
 =?utf-8?B?bEJUM0l3RXJQR3IxNkZSc0xoT2dLdjFmaWdBQUlNcWJXcU42d3hlVTJSN0Y1?=
 =?utf-8?B?czlwV2Y4VWNjZ0c2NXhidklKRUdaNC9RMTJRWFV1QlVVaXJEMFVCQ3U4WkFZ?=
 =?utf-8?B?bkxDV0x2em1rUVkyb1dUczdlR2NOZWpITm1lTU0yS1hrcTZ2ZjBBeU9xd0pP?=
 =?utf-8?B?ci9oQVoxN1cycjNmSTRZMVNmWkR5d2NpbW4vQjVJN1FzbUZMa0ZQbU1iQitW?=
 =?utf-8?Q?TLsq9YyFrN2f63HQAkEPnaqoQoxQEjFuZL4jSq8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aff768-5396-4935-4065-08d974997d03
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5163.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 20:28:02.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4rCrOoldF+y3kPhKxg5TMr390q9xoeOOTUjt82FOl9AX5l5HAe5QUQhhJtk1ib2cFYRipoFOeVk6X3gUP6FyrjtAQbTLk/UhlCSyTcY4ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 9/10/21 8:13 AM, Xu Yilun wrote:
> On Thu, Sep 09, 2021 at 04:33:01PM -0700, Russ Weight wrote:
>> Create a sub driver for the FPGA Card BMC in order to support secure
>> updates.  This sub-driver will invoke an instance of the FPGA Image Load
>> class driver for the image load portion of the update.
>>
>> This patch creates the MAX10 BMC Secure Update driver and provides sysfs
>> files for displaying the current root entry hashes for the FPGA static
>> region, the FPGA PR region, and the MAX10 BMC.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>> ---
>> v14:
>>   - Changed symbol and text references to reflect the renaming of the
>>     Security Manager Class driver to FPGA Image Load.
>> v13:
>>   - Updated copyright to 2021
>>   - Updated ABI documentation date and kernel version
>>   - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
>>     functions instead of devm_fpga_sec_mgr_create() and
>>     devm_fpga_sec_mgr_register().
>> v12:
>>   - Updated Date and KernelVersion fields in ABI documentation
>> v11:
>>   - Added Reviewed-by tag
>> v10:
>>   - Changed the path expressions in the sysfs documentation to
>>     replace the n3000 reference with something more generic to
>>     accomodate other devices that use the same driver.
>> v9:
>>   - Rebased to 5.12-rc2 next
>>   - Updated Date and KernelVersion in ABI documentation
>> v8:
>>   - Previously patch 2/6, otherwise no change
>> v7:
>>   - Updated Date and KernelVersion in ABI documentation
>> v6:
>>   - Added WARN_ON() call for (sha_num_bytes / stride) to assert
>>     that the proper count is passed to regmap_bulk_read().
>> v5:
>>   - No change
>> v4:
>>   - Moved sysfs files for displaying the root entry hashes (REH)
>>     from the FPGA Security Manager class driver to here. The
>>     m10bmc_reh() and m10bmc_reh_size() functions are removed and
>>     the functionality from these functions is moved into a
>>     show_root_entry_hash() function for displaying the REHs.
>>   - Added ABI documentation for the new sysfs entries:
>>     sysfs-driver-intel-m10-bmc-secure
>>   - Updated the MAINTAINERS file to add the new ABI documentation
>>     file: sysfs-driver-intel-m10-bmc-secure
>>   - Removed unnecessary ret variable from m10bmc_secure_probe()
>>   - Incorporated new devm_fpga_sec_mgr_register() function into
>>     m10bmc_secure_probe() and removed the m10bmc_secure_remove()
>>     function.
>> v3:
>>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
>>   - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
>>     Update driver"
>>   - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
>>     underlying functions are now called directly.
>>   - Changed "_root_entry_hash" to "_reh", with a comment explaining
>>     what reh is.
>> v2:
>>   - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
>>   - Switched to GENMASK(31, 16) for a couple of mask definitions.
>>   - Moved MAX10 BMC address and function definitions to a separate
>>     patch.
>>   - Replaced small function-creation macros with explicit function
>>     declarations.
>>   - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
>>   - Adapted to changes in the Intel FPGA Security Manager by splitting
>>     the single call to ifpga_sec_mgr_register() into two function
>>     calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
>> ---
>>  .../testing/sysfs-driver-intel-m10-bmc-secure |  29 ++++
>>  MAINTAINERS                                   |   2 +
>>  drivers/fpga/Kconfig                          |  11 ++
>>  drivers/fpga/Makefile                         |   3 +
>>  drivers/fpga/intel-m10-bmc-secure.c           | 145 ++++++++++++++++++
>>  5 files changed, 190 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>>  create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>> new file mode 100644
>> index 000000000000..363403ce992d
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
>> @@ -0,0 +1,29 @@
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_root_entry_hash
>> +Date:		Aug 2021
>> +KernelVersion:	5.15
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the static
>> +		region if one is programmed, else it returns the
>> +		string: "hash not programmed".  This file is only
>> +		visible if the underlying device supports it.
>> +		Format: "0x%x".
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_root_entry_hash
>> +Date:		Aug 2021
>> +KernelVersion:	5.15
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the partial
>> +		reconfiguration region if one is programmed, else it
>> +		returns the string: "hash not programmed".  This file
>> +		is only visible if the underlying device supports it.
>> +		Format: "0x%x".
>> +
>> +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_root_entry_hash
>> +Date:		Aug 2021
>> +KernelVersion:	5.15
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	Read only. Returns the root entry hash for the BMC image
>> +		if one is programmed, else it returns the string:
>> +		"hash not programmed".  This file is only visible if the
>> +		underlying device supports it.
>> +		Format: "0x%x".
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e3fbc1bde9bc..cf93835b4775 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7363,8 +7363,10 @@ M:	Russ Weight <russell.h.weight@intel.com>
>>  L:	linux-fpga@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
>> +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> Should we change the name of the driver? Some keywords like "image load"
> or "firmware update" should be in the name.

I considered that. The image-upload functionality is a subset of  this
driver. It also exposes security collateral via sysfs, and the image-load
triggers and power-on-image sysfs files will probably end up in this
driver too.

The current driver name is intel-m10-bmc-secure. Do we need to keep
"intel-m10-bmc" in the name?

intel-m10-bmc-sec-fw-update?
intel-m10-bmc-sec-update?

What do you think? Any other suggestions?

- Russ
>
> Thanks,
> Yilun
>
>>  F:	Documentation/fpga/fpga-image-load.rst
>>  F:	drivers/fpga/fpga-image-load.c
>> +F:	drivers/fpga/intel-m10-bmc-secure.c
>>  F:	include/linux/fpga/fpga-image-load.h
>>  F:	include/uapi/linux/fpga-image-load.h
>>  
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index c12a14e62fff..9d25b1ec03cd 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -253,4 +253,15 @@ config FPGA_IMAGE_LOAD
>>  	  and/or the device itself to authenticate and disposition the
>>  	  image data.
>>  
>> +config FPGA_M10_BMC_SECURE
>> +	tristate "Intel MAX10 BMC Secure Update driver"
>> +	depends on MFD_INTEL_M10_BMC && FPGA_IMAGE_LOAD
>> +	help
>> +	  Secure update support for the Intel MAX10 board management
>> +	  controller.
>> +
>> +	  This is a subdriver of the Intel MAX10 board management controller
>> +	  (BMC) and provides support for secure updates for the BMC image,
>> +	  the FPGA image, the Root Entry Hashes, etc.
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index adf228ee4f5e..8d4c1869ac4c 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -25,6 +25,9 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>>  # FPGA Image Load Framework
>>  obj-$(CONFIG_FPGA_IMAGE_LOAD)		+= fpga-image-load.o
>>  
>> +# FPGA Secure Update Drivers
>> +obj-$(CONFIG_FPGA_M10_BMC_SECURE)	+= intel-m10-bmc-secure.o
>> +
>>  # FPGA Bridge Drivers
>>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
>> diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
>> new file mode 100644
>> index 000000000000..03fc571f40f2
>> --- /dev/null
>> +++ b/drivers/fpga/intel-m10-bmc-secure.c
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Intel Max10 Board Management Controller Secure Update Driver
>> + *
>> + * Copyright (C) 2019-2021 Intel Corporation. All rights reserved.
>> + *
>> + */
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/fpga/fpga-image-load.h>
>> +#include <linux/mfd/intel-m10-bmc.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +struct m10bmc_sec {
>> +	struct device *dev;
>> +	struct intel_m10bmc *m10bmc;
>> +	struct fpga_image_load *imgld;
>> +};
>> +
>> +/* Root Entry Hash (REH) support */
>> +#define REH_SHA256_SIZE		32
>> +#define REH_SHA384_SIZE		48
>> +#define REH_MAGIC		GENMASK(15, 0)
>> +#define REH_SHA_NUM_BYTES	GENMASK(31, 16)
>> +
>> +static ssize_t
>> +show_root_entry_hash(struct device *dev, u32 exp_magic,
>> +		     u32 prog_addr, u32 reh_addr, char *buf)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>> +	unsigned int stride = regmap_get_reg_stride(sec->m10bmc->regmap);
>> +	int sha_num_bytes, i, cnt, ret;
>> +	u8 hash[REH_SHA384_SIZE];
>> +	u32 magic;
>> +
>> +	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(dev, "%s magic 0x%08x\n", __func__, magic);
>> +
>> +	if (FIELD_GET(REH_MAGIC, magic) != exp_magic)
>> +		return sysfs_emit(buf, "hash not programmed\n");
>> +
>> +	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
>> +	if (sha_num_bytes != REH_SHA256_SIZE &&
>> +	    sha_num_bytes != REH_SHA384_SIZE)   {
>> +		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
>> +			sha_num_bytes);
>> +		return -EINVAL;
>> +	}
>> +
>> +	WARN_ON(sha_num_bytes % stride);
>> +	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
>> +			       hash, sha_num_bytes / stride);
>> +	if (ret) {
>> +		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
>> +			reh_addr, sha_num_bytes / stride, ret);
>> +		return ret;
>> +	}
>> +
>> +	cnt = sprintf(buf, "0x");
>> +	for (i = 0; i < sha_num_bytes; i++)
>> +		cnt += sprintf(buf + cnt, "%02x", hash[i]);
>> +	cnt += sprintf(buf + cnt, "\n");
>> +
>> +	return cnt;
>> +}
>> +
>> +#define DEVICE_ATTR_SEC_REH_RO(_name, _magic, _prog_addr, _reh_addr) \
>> +static ssize_t _name##_root_entry_hash_show(struct device *dev, \
>> +					    struct device_attribute *attr, \
>> +					    char *buf) \
>> +{ return show_root_entry_hash(dev, _magic, _prog_addr, _reh_addr, buf); } \
>> +static DEVICE_ATTR_RO(_name##_root_entry_hash)
>> +
>> +DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
>> +DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
>> +
>> +static struct attribute *m10bmc_security_attrs[] = {
>> +	&dev_attr_bmc_root_entry_hash.attr,
>> +	&dev_attr_sr_root_entry_hash.attr,
>> +	&dev_attr_pr_root_entry_hash.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group m10bmc_security_attr_group = {
>> +	.name = "security",
>> +	.attrs = m10bmc_security_attrs,
>> +};
>> +
>> +static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>> +	&m10bmc_security_attr_group,
>> +	NULL,
>> +};
>> +
>> +static const struct fpga_image_load_ops m10bmc_lops = { };
>> +
>> +static int m10bmc_secure_probe(struct platform_device *pdev)
>> +{
>> +	struct fpga_image_load *imgld;
>> +	struct m10bmc_sec *sec;
>> +
>> +	sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> +	if (!sec)
>> +		return -ENOMEM;
>> +
>> +	sec->dev = &pdev->dev;
>> +	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +	dev_set_drvdata(&pdev->dev, sec);
>> +
>> +	imgld = fpga_image_load_register(sec->dev, &m10bmc_lops, sec);
>> +	if (IS_ERR(imgld)) {
>> +		dev_err(sec->dev, "FPGA Image Load driver failed to start\n");
>> +		return PTR_ERR(imgld);
>> +	}
>> +
>> +	sec->imgld = imgld;
>> +	return 0;
>> +}
>> +
>> +static int m10bmc_secure_remove(struct platform_device *pdev)
>> +{
>> +	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>> +
>> +	fpga_image_load_unregister(sec->imgld);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver intel_m10bmc_secure_driver = {
>> +	.probe = m10bmc_secure_probe,
>> +	.remove = m10bmc_secure_remove,
>> +	.driver = {
>> +		.name = "n3000bmc-secure",
>> +		.dev_groups = m10bmc_sec_attr_groups,
>> +	},
>> +};
>> +module_platform_driver(intel_m10bmc_secure_driver);
>> +
>> +MODULE_ALIAS("platform:n3000bmc-secure");
>> +MODULE_AUTHOR("Intel Corporation");
>> +MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.25.1

