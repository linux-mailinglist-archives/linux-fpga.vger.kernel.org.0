Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0604D6D8E20
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Apr 2023 05:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjDFDz3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Apr 2023 23:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjDFDz2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Apr 2023 23:55:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C13ABC;
        Wed,  5 Apr 2023 20:55:26 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PsSJH60N3zKx16;
        Thu,  6 Apr 2023 11:52:47 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Apr 2023 11:54:59 +0800
CC:     <yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Robert Richter <rric@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Frank Li <Frank.li@nxp.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH 31/32] Documentation: ABI + trace: hisi_ptt: update paths
 to bus/event_source
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>
References: <20230404134225.13408-1-Jonathan.Cameron@huawei.com>
 <20230404134225.13408-32-Jonathan.Cameron@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d7f016b8-b848-d5de-a785-72e0669e21d2@huawei.com>
Date:   Thu, 6 Apr 2023 11:54:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230404134225.13408-32-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023/4/4 21:42, Jonathan Cameron wrote:
> To allow for assigning a suitable parent to the struct pmu device
> update the documentation to describe the device via the event_source
> bus where it will remain accessible.
> 
> For the ABI documention file also rename the file as it is named
> after the path.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  ...i_ptt => sysfs-bus-event_source-devices-hisi_ptt} | 12 ++++++------
>  Documentation/trace/hisi-ptt.rst                     |  4 ++--
>  MAINTAINERS                                          |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
> similarity index 83%
> rename from Documentation/ABI/testing/sysfs-devices-hisi_ptt
> rename to Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
> index 82de6d710266..f2f48f7ce887 100644
> --- a/Documentation/ABI/testing/sysfs-devices-hisi_ptt
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
> @@ -1,4 +1,4 @@
> -What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
> +What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune
>  Date:		October 2022
>  KernelVersion:	6.1
>  Contact:	Yicong Yang <yangyicong@hisilicon.com>
> @@ -8,7 +8,7 @@ Description:	This directory contains files for tuning the PCIe link
>  
>  		See Documentation/trace/hisi-ptt.rst for more information.
>  
> -What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_cpl
> +What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_cpl
>  Date:		October 2022
>  KernelVersion:	6.1
>  Contact:	Yicong Yang <yangyicong@hisilicon.com>
> @@ -18,7 +18,7 @@ Description:	(RW) Controls the weight of Tx completion TLPs, which influence
>  		will return an error, and out of range values will be converted
>  		to 2. The value indicates a probable level of the event.
>  
> -What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_np
> +What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_np
>  Date:		October 2022
>  KernelVersion:	6.1
>  Contact:	Yicong Yang <yangyicong@hisilicon.com>
> @@ -28,7 +28,7 @@ Description:	(RW) Controls the weight of Tx non-posted TLPs, which influence
>  		will return an error, and out of range values will be converted
>  		to 2. The value indicates a probable level of the event.
>  
> -What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_p
> +What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_p
>  Date:		October 2022
>  KernelVersion:	6.1
>  Contact:	Yicong Yang <yangyicong@hisilicon.com>
> @@ -38,7 +38,7 @@ Description:	(RW) Controls the weight of Tx posted TLPs, which influence the
>  		will return an error, and out of range values will be converted
>  		to 2. The value indicates a probable level of the event.
>  
> -What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/rx_alloc_buf_level
> +What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/rx_alloc_buf_level
>  Date:		October 2022
>  KernelVersion:	6.1
>  Contact:	Yicong Yang <yangyicong@hisilicon.com>
> @@ -49,7 +49,7 @@ Description:	(RW) Control the allocated buffer watermark for inbound packets.
>  		will return an error, and out of range values will be converted
>  		to 2. The value indicates a probable level of the event.
>  
> -What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/tx_alloc_buf_level
> +What:		/sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune/tx_alloc_buf_level
>  Date:		October 2022
>  KernelVersion:	6.1
>  Contact:	Yicong Yang <yangyicong@hisilicon.com>
> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> index 4f87d8e21065..d923e09fcbaa 100644
> --- a/Documentation/trace/hisi-ptt.rst
> +++ b/Documentation/trace/hisi-ptt.rst
> @@ -40,7 +40,7 @@ IO dies (SICL, Super I/O Cluster), where there's one PCIe Root
>  Complex for each SICL.
>  ::
>  
> -    /sys/devices/hisi_ptt<sicl_id>_<core_id>
> +    /sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>
>  
>  Tune
>  ====
> @@ -53,7 +53,7 @@ Each event is presented as a file under $(PTT PMU dir)/tune, and
>  a simple open/read/write/close cycle will be used to tune the event.
>  ::
>  
> -    $ cd /sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
> +    $ cd /sys/bus/event_source/devices/hisi_ptt<sicl_id>_<core_id>/tune
>      $ ls
>      qos_tx_cpl    qos_tx_np    qos_tx_p
>      tx_path_rx_req_alloc_buf_level
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8ebab595b2a..75019f62b1df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9266,7 +9266,7 @@ M:	Yicong Yang <yangyicong@hisilicon.com>
>  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-devices-hisi_ptt
> +F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
>  F:	Documentation/trace/hisi-ptt.rst
>  F:	drivers/hwtracing/ptt/
>  F:	tools/perf/arch/arm64/util/hisi-ptt.c
> 
