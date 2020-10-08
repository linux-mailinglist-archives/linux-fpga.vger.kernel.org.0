Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383EF286C40
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Oct 2020 02:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgJHAwy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Oct 2020 20:52:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:2561 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbgJHAwy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Oct 2020 20:52:54 -0400
IronPort-SDR: Qrk24QT1GxouX3XTnQZcBLFg60wcbx3I9yH2uJzJeqEZe3xnRyg4Gsjv7X3TztqUyrPWv2qlNe
 jgVoFJG8SK8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="153038298"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="153038298"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:52:52 -0700
IronPort-SDR: 6BraDRlabT/6gkmHjsWYxonEVETu9NzXUvn8sfhc7X5bnKElamnJHZarY2CQDOPQZUvSvPKbAv
 5P/gHTVg+6CQ==
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="461593617"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.251.1.22])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:52:52 -0700
Subject: Re: [PATCH v2 1/6] mfd: intel-m10-bmc: support for MAX10 BMC Security
 Engine
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-2-russell.h.weight@intel.com>
 <6eef3a9a-ffc9-7e93-e3ef-69e755fbf8cc@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <53a712e8-63e5-8b75-a2a4-6bf7fa327462@intel.com>
Date:   Wed, 7 Oct 2020 17:52:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6eef3a9a-ffc9-7e93-e3ef-69e755fbf8cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 10/6/20 9:34 AM, Tom Rix wrote:
> On 10/2/20 6:24 PM, Russ Weight wrote:
>> Add macros and definitions required by the MAX10 BMC
>> Security Engine driver.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v2:
>>   - These functions and macros were previously distributed among
>>     the patches that needed them. They are now grouped together
>>     in a single patch containing changes to the Intel MAX10 BMC
>>     driver.
>>   - Added DRBL_ prefix to some definitions
>>   - Some address definitions were moved here from the .c files that
>>     use them.
>> ---
>>  include/linux/mfd/intel-m10-bmc.h | 134 ++++++++++++++++++++++++++++++
>>  1 file changed, 134 insertions(+)
>>
>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
>> index c8ef2f1654a4..880f907302eb 100644
>> --- a/include/linux/mfd/intel-m10-bmc.h
>> +++ b/include/linux/mfd/intel-m10-bmc.h
>> @@ -13,6 +13,9 @@
>>  #define M10BMC_SYS_BASE			0x300800
>>  #define M10BMC_MEM_END			0x200000fc
>>  
>> +#define M10BMC_STAGING_BASE		0x18000000
>> +#define M10BMC_STAGING_SIZE		0x3800000
> The staging size is not used, please use it in m10bmc_sec_write_blk to
>
> check the input parameter 'size'

It is used to check the input size in the prepare function:
m10bmc_sec_prepare()

        if (smgr->remaining_size > M10BMC_STAGING_SIZE)
                return FPGA_SEC_ERR_INVALID_SIZE;

- Russ

>
>> +
>>  /* Register offset of system registers */
>>  #define NIOS2_FW_VERSION		0x0
>>  #define M10BMC_TEST_REG			0x3c
>> @@ -21,6 +24,88 @@
>>  #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
>>  #define M10BMC_VER_LEGACY_INVALID	0xffffffff
>>  
>> +/* Secure update doorbell register, in system register region */
>> +#define M10BMC_DOORBELL			0x400
>> +
>> +/* Authorization Result register, in system register region */
>> +#define M10BMC_AUTH_RESULT		0x404
>> +
>> +/* Doorbell register fields */
>> +#define DRBL_RSU_REQUEST		BIT(0)
>> +#define DRBL_RSU_PROGRESS		GENMASK(7, 4)
>> +#define DRBL_HOST_STATUS		GENMASK(11, 8)
>> +#define DRBL_RSU_STATUS			GENMASK(23, 16)
>> +#define DRBL_PKVL_EEPROM_LOAD_SEC	BIT(24)
>> +#define DRBL_PKVL1_POLL_EN		BIT(25)
>> +#define DRBL_PKVL2_POLL_EN		BIT(26)
> PKVL seems like it would be n3000 specific.
>
> For this and similar it may be good to add a _N3000_ in the name.
>
>> +#define DRBL_CONFIG_SEL			BIT(28)
>> +#define DRBL_REBOOT_REQ			BIT(29)
>> +#define DRBL_REBOOT_DISABLED		BIT(30)
>> +
>> +/* Progress states */
>> +#define RSU_PROG_IDLE			0x0
>> +#define RSU_PROG_PREPARE		0x1
>> +#define RSU_PROG_READY			0x3
>> +#define RSU_PROG_AUTHENTICATING		0x4
>> +#define RSU_PROG_COPYING		0x5
>> +#define RSU_PROG_UPDATE_CANCEL		0x6
>> +#define RSU_PROG_PROGRAM_KEY_HASH	0x7
>> +#define RSU_PROG_RSU_DONE		0x8
>> +#define RSU_PROG_PKVL_PROM_DONE		0x9
>> +
>> +/* Device and error states */
>> +#define RSU_STAT_NORMAL			0x0
>> +#define RSU_STAT_TIMEOUT		0x1
>> +#define RSU_STAT_AUTH_FAIL		0x2
>> +#define RSU_STAT_COPY_FAIL		0x3
>> +#define RSU_STAT_FATAL			0x4
>> +#define RSU_STAT_PKVL_REJECT		0x5
>> +#define RSU_STAT_NON_INC		0x6
>> +#define RSU_STAT_ERASE_FAIL		0x7
>> +#define RSU_STAT_WEAROUT		0x8
>> +#define RSU_STAT_NIOS_OK		0x80
>> +#define RSU_STAT_USER_OK		0x81
>> +#define RSU_STAT_FACTORY_OK		0x82
>> +#define RSU_STAT_USER_FAIL		0x83
>> +#define RSU_STAT_FACTORY_FAIL		0x84
>> +#define RSU_STAT_NIOS_FLASH_ERR		0x85
>> +#define RSU_STAT_FPGA_FLASH_ERR		0x86
>> +
>> +#define HOST_STATUS_IDLE		0x0
>> +#define HOST_STATUS_WRITE_DONE		0x1
>> +#define HOST_STATUS_ABORT_RSU		0x2
>> +
>> +#define rsu_prog(doorbell)	FIELD_GET(DRBL_RSU_PROGRESS, doorbell)
>> +#define rsu_stat(doorbell)	FIELD_GET(DRBL_RSU_STATUS, doorbell)
>> +
>> +/* interval 100ms and timeout 5s */
>> +#define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
>> +#define NIOS_HANDSHAKE_TIMEOUT_US	(5 * 1000 * 1000)
>> +
>> +/* RSU PREP Timeout (2 minutes) to erase flash staging area */
>> +#define RSU_PREP_INTERVAL_MS		100
>> +#define RSU_PREP_TIMEOUT_MS		(2 * 60 * 1000)
>> +
>> +/* RSU Complete Timeout (40 minutes) for full flash update */
>> +#define RSU_COMPLETE_INTERVAL_MS	1000
>> +#define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
> minutes is an unusual timeout unit.
>
> It may be worthwhile to spell out MINUTES to avoid confusing with micro seconds.
>
> Tom
>
>> +
>> +/* Addresses for security related data in FLASH */
>> +#define BMC_REH_ADDR	0x17ffc004
>> +#define BMC_PROG_ADDR	0x17ffc000
>> +#define BMC_PROG_MAGIC	0x5746
>> +
>> +#define SR_REH_ADDR	0x17ffd004
>> +#define SR_PROG_ADDR	0x17ffd000
>> +#define SR_PROG_MAGIC	0x5253
>> +
>> +#define PR_REH_ADDR	0x17ffe004
>> +#define PR_PROG_ADDR	0x17ffe000
>> +#define PR_PROG_MAGIC	0x5250
>> +
>> +/* Address of inverted bit vector containing user the image FLASH count */
>> +#define USER_FLASH_COUNT 0x17ffb000
>> +
>>  /**
>>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
>>   * @dev: this device
>> @@ -35,7 +120,11 @@ struct intel_m10bmc {
>>   * register access helper functions.
>>   *
>>   * m10bmc_raw_read - read m10bmc register per addr
>> + * m10bmc_raw_bulk_read - bulk read max10 registers per addr
>> + * m10bmc_raw_bulk_write - bulk write max10 registers per addr
>> + * m10bmc_raw_update_bits - update max10 register per addr
>>   * m10bmc_sys_read - read m10bmc system register per offset
>> + * m10bmc_sys_update_bits - update max10 system register per offset
>>   */
>>  static inline int
>>  m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>> @@ -51,6 +140,48 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>>  	return ret;
>>  }
>>  
>> +static inline int
>> +m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>> +		     void *val, size_t cnt)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(m10bmc->regmap, addr, val, cnt);
>> +	if (ret)
>> +		dev_err(m10bmc->dev, "fail to read raw reg %x cnt %zx: %d\n",
>> +			addr, cnt, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int
>> +m10bmc_raw_bulk_write(struct intel_m10bmc *m10bmc, unsigned int addr,
>> +		      void *val, size_t cnt)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_bulk_write(m10bmc->regmap, addr, val, cnt);
>> +	if (ret)
>> +		dev_err(m10bmc->dev, "fail to write raw reg %x cnt %zx: %d\n",
>> +			addr, cnt, ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static inline int
>> +m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
>> +		       unsigned int msk, unsigned int val)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
>> +	if (ret)
>> +		dev_err(m10bmc->dev, "fail to update raw reg %x: %d\n",
>> +			addr, ret);
>> +
>> +	return ret;
>> +}
>> +
>>  /*
>>   * The base of the system registers could be configured by HW developers, and
>>   * in HW SPEC, the base is not added to the addresses of the system registers.
>> @@ -62,4 +193,7 @@ m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>>  #define m10bmc_sys_read(m10bmc, offset, val) \
>>  	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
>>  
>> +#define m10bmc_sys_update_bits(m10bmc, offset, msk, val) \
>> +	m10bmc_raw_update_bits(m10bmc, M10BMC_SYS_BASE + (offset), msk, val)
>> +
>>  #endif /* __MFD_INTEL_M10_BMC_H */

