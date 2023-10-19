Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEC27CEDDE
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Oct 2023 04:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjJSCLd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJSCLd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 22:11:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8860113
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 19:11:29 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9rgP2G34zvQFh;
        Thu, 19 Oct 2023 10:06:41 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 10:11:26 +0800
Message-ID: <23fd374b-aab1-bfe1-d1ab-066df0ab6902@huawei.com>
Date:   Thu, 19 Oct 2023 10:11:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
To:     Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>
CC:     Xu Yilun <yilun.xu@linux.intel.com>, <yilun.xu@intel.com>,
        <linux-fpga@vger.kernel.org>, <hao.wu@intel.com>, <mdf@kernel.org>
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
 <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
 <2023101825-ligament-undergrad-cc4d@gregkh>
 <e178f915-fc65-48a1-abab-05d1202319a4@redhat.com>
 <2023101848-smith-tastiness-1459@gregkh>
Content-Language: en-US
From:   Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <2023101848-smith-tastiness-1459@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023/10/18 19:50, Greg KH wrote:
> On Wed, Oct 18, 2023 at 11:39:01AM +0200, Marco Pagani wrote:
>>
>>
>> On 18/10/23 09:50, Greg KH wrote:
>>> On Wed, Oct 18, 2023 at 10:02:08AM +0800, Xu Yilun wrote:
>>>> On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
>>>>> On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
>>>>>> The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
>>>>>>
>>>>>>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
>>>>>>
>>>>>> for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
>>>>>>
>>>>>>   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> FPGA Manager changes for 6.6-final
>>>>>>
>>>>>> FPGA KUnit test:
>>>>>>
>>>>>> - Marco's change fixes null-ptr-deref when try_module_get()
>>>>>> - Jinjie's change fixes a memory leak issue
>>>>>>
>>>>>> Intel m10 bmc secure update:
>>>>>>
>>>>>> - Maintainer change from Russ Weight to Peter Colberg
>>>>>>
>>>>>> All patches have been reviewed on the mailing list, and have been in the
>>>>>> last linux-next releases (as part of our fixes branch)
>>>>>>
>>>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Jinjie Ruan (1):
>>>>>>       fpga: Fix memory leak for fpga_region_test_class_find()
>>>>>>
>>>>>> Marco Pagani (4):
>>>>>>       fpga: add helpers for the FPGA KUnit test suites.
>>>>>>       fpga: add a platform driver to the FPGA Manager test suite
>>>>>>       fpga: add a platform driver to the FPGA Bridge test suite
>>>>>>       fpga: add a platform driver to the FPGA Region test suite
>>>>>
>>>>> Why are all of these test suite patches here?  They are not relevant for
>>>>> 6.6-final as they do not resolve anything.
>>>>
>>>> Maybe the subjects indicate no bug fixing, but they fix null-ptr-deref
>>>> issues when modprobe fpga-mgr/bridge/region-test.
>>>
>>> That's not obvious, sorry.  So are the tests broken right now so that
>>> they don't work at all?
>>
>> They were broken only when compiled and run as modules.
> 
> Then forbid the ability to compile them as modules.

There is also a null-ptr-deref for fpga-mgr/bridge/region-test when
CONFIG_FPGA_KUNIT_TESTS=y

[  115.526321] ok 76 rtc_lib_test_cases
[  115.528830]     KTAP version 1
[  115.529612]     # Subtest: fpga_mgr
[  115.530500]     # module: fpga_mgr_test
[  115.530507]     1..4
[  115.533848] general protection fault, probably for non-canonical
address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
[  115.536884] KASAN: null-ptr-deref in range
[0x0000000000000010-0x0000000000000017]
[  115.538778] CPU: 2 PID: 2171 Comm: kunit_try_catch Tainted: G    B
W        N 6.6.0-rc6+ #125
[  115.540918] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  115.543163] RIP: 0010:__fpga_mgr_get+0x63/0xb0
[  115.544290] Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 75 52
48 b8 00 00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea
03 <807b 10 e8 7e b1 97 fd 84 c0 74 08 4c 89 e0
[  115.548872] RSP: 0000:ffff88810909fe18 EFLAGS: 00010202
[  115.550179] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
ffffffff8402d6ac
[  115.551944] RDX: 0000000000000002 RSI: 0000000000000004 RDI:
0000000000000010
[  115.553705] RBP: ffff8881078ba808 R08: ffffed1021213f96 R09:
ffffed10203c0acb
[  115.555465] R10: ffffed10203c0aca R11: ffff888101e05653 R12:
ffff8881078ba800
[  115.557222] R13: ffff8881064bc958 R14: ffff888100b57b20 R15:
ffff888109b45440
[  115.559000] FS:  0000000000000000(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[  115.560989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  115.562427] CR2: ffff888119750000 CR3: 0000000005285001 CR4:
0000000000170ee0
[  115.564207] DR0: ffffffff8fe17ce0 DR1: ffffffff8fe17ce1 DR2:
ffffffff8fe17ce3
[  115.565973] DR3: ffffffff8fe17ce5 DR6: 00000000ffff0ff0 DR7:
0000000000000600
[  115.567757] Call Trace:
[  115.568372]  <TASK>
[  115.568926]  ? __die_body+0x1b/0x60
[  115.569812]  ? die_addr+0x43/0x70
[  115.570651]  ? exc_general_protection+0x121/0x210
[  115.571849]  ? asm_exc_general_protection+0x22/0x30
[  115.573069]  ? kobject_put+0x5c/0x310
[  115.573999]  ? __fpga_mgr_get+0x63/0xb0
[  115.574993]  fpga_mgr_test_get+0xb6/0x1b0
[  115.576008]  ? platform_device_register_simple.constprop.0+0xc0/0xc0
[  115.577580]  ? fpga_mgr_test_lock+0x200/0x200
[  115.578713]  ? kunit_try_run_case+0xdd/0x250
[  115.579794]  ? kunit_suite_has_succeeded+0x50/0x50
[  115.580990]  kunit_generic_run_threadfn_adapter+0x4a/0x90
[  115.582345]  ? kunit_try_catch_throw+0x80/0x80
[  115.583460]  kthread+0x2b6/0x380
[  115.584289]  ? kthread_complete_and_exit+0x20/0x20
[  115.585485]  ret_from_fork+0x2d/0x70
[  115.586407]  ? kthread_complete_and_exit+0x20/0x20
[  115.587607]  ret_from_fork_asm+0x11/0x20
[  115.588595]  </TASK>
[  115.589165] Modules linked in:
[  115.589954] Dumping ftrace buffer:
[  115.590854]    (ftrace buffer empty)
[  115.591804] ---[ end trace 0000000000000000 ]---
[  115.592999] RIP: 0010:__fpga_mgr_get+0x63/0xb0
[  115.594152] Code: 48 8d 7b 68 48 89 fa 48 c1 ea 03 80 3c 02 00 75 52
48 b8 00 00 00 00 00 fc ff df 48 8b 5b 68 48 8d 7b 10 48 89 fa 48 c1 ea
03 <807b 10 e8 7e b1 97 fd 84 c0 74 08 4c 89 e0
[  115.598801] RSP: 0000:ffff88810909fe18 EFLAGS: 00010202
[  115.600119] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
ffffffff8402d6ac
[  115.601900] RDX: 0000000000000002 RSI: 0000000000000004 RDI:
0000000000000010
[  115.603690] RBP: ffff8881078ba808 R08: ffffed1021213f96 R09:
ffffed10203c0acb
[  115.605460] R10: ffffed10203c0aca R11: ffff888101e05653 R12:
ffff8881078ba800
[  115.607253] R13: ffff8881064bc958 R14: ffff888100b57b20 R15:
ffff888109b45440
[  115.609047] FS:  0000000000000000(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[  115.611063] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  115.612500] CR2: ffff888119750000 CR3: 0000000005285001 CR4:
0000000000170ee0
[  115.614301] DR0: ffffffff8fe17ce0 DR1: ffffffff8fe17ce1 DR2:
ffffffff8fe17ce3
[  115.616088] DR3: ffffffff8fe17ce5 DR6: 00000000ffff0ff0 DR7:
0000000000000600
[  115.617890] Kernel panic - not syncing: Fatal exception
[  115.619425] Dumping ftrace buffer:
[  115.620271]    (ftrace buffer empty)
[  115.621151] Kernel Offset: disabled
[  115.622007] Rebooting in 1 seconds..


> 
>>>> In fpga-mgr-test, the pdev->dev->driver is not assigned, so when
>>>>
>>>>   fpga_mgr_test_get()->try_module_get(dev->parent->driver->owner)
>>>
>>> That's a horrible line and should be fixed.  How do you know if a device
>>> has a parent, or if that parent has a driver?  You don't, that should be
>>> fixed instead.
>>>
>>> And module_get on a driver pointer is also never a good idea for other
>>> reasons, why is this happening at all?  It shouldn't be needed if the
>>> code is set up properly (i.e. the unloading of a driver will handle the
>>> shutdown and reference counting properly, no need to try to use module
>>> references at all.)
>>
>> You are right, but fixing the fpga core is outside the scope of my patches.
> 
> Which is why I'm not going to take these as you aren't fixing the root
> problem here :)
> 
>> My intent was to improve the test suite by adding fake drivers irrespective
>> of the fpga core quirks. I might try to send an RFC later to improve the
>> fpga core.
>>
>>>
>>>> NULL ptr is referenced.
>>>>
>>>> So do fpga-bridge/region-test.
>>>>
>>>> Patch #1 adds a common helper to generate a platform driver.
>>>
>>> Don't abuse platform devices/drivers like this, this is not a platform
>>> device or driver.  If you really want to do this, use a real driver and
>>> device, not a platform one please.
>>
>> Other test suites, like DRM suites, already use fake platform devices and
>> drivers. Moreover, many real FPGA IPs, like reconfiguration controllers and
>> bridges, are indeed modeled as platform devices. What is the benefit of
>> using a real driver and device?
> 
> Again, please do not abuse platform devices and drivers when they should
> not be used.  I can't catch all abuses, but when I do see them, I do
> object to them.
> 
> And again, the root problem here isn't even a platform device issue,
> it's a "assuming the parent has a driver and we want to increment a
> module reference" issue.  That's not ok, nor even needed at all.
> 
> thanks,
> 
> greg k-h
