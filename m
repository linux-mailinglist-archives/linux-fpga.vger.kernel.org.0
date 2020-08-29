Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7343256A4B
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Aug 2020 23:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgH2VIr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 29 Aug 2020 17:08:47 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:50688 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbgH2VIp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 29 Aug 2020 17:08:45 -0400
Received: from [78.134.86.56] (port=59664 helo=[192.168.77.66])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kC85Z-0008dc-VF; Sat, 29 Aug 2020 23:08:42 +0200
Subject: Re: [PATCH v3 4/5] fpga manager: xilinx-spi: add error checking after
 gpiod_get_value()
To:     kernel test robot <lkp@intel.com>, linux-fpga@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>, Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200828195808.27975-4-luca@lucaceresoli.net>
 <202008291117.tPETSgId%lkp@intel.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <d7478021-33cd-4477-8fa5-3336048d8afe@lucaceresoli.net>
Date:   Sat, 29 Aug 2020 23:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008291117.tPETSgId%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On 29/08/20 05:30, kernel test robot wrote:
> Hi Luca,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on v5.9-rc2]
> [also build test WARNING on next-20200828]
> [cannot apply to xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Luca-Ceresoli/fpga-manager-xilinx-spi-remove-stray-comment/20200829-040041
> base:    d012a7190fc1fd72ed48911e77ca97ba4521bccd
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> cppcheck warnings: (new ones prefixed by >>)
> 
>>> drivers/fpga/xilinx-spi.c:183:10: warning: Uninitialized variable: expired [uninitvar]
>     while (!expired) {
>             ^

Oh dear, Please ignore this patch, v4 will be coming with this fixed.

-- 
Luca
