Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A987B5A4509
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiH2I2b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 04:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiH2I2a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 04:28:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5350E5789E;
        Mon, 29 Aug 2022 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661761709; x=1693297709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0jKxfltx8LzS4R2NuQtuKBbEC8CniiDMrw7te6Rek4=;
  b=DLz1CCQicTpvvmdz466tf4w1zlPXfBOOumqijrFqDZno1EL5/Ov0qy/z
   r8r8I0QOksW0QmyyS339gUwsM/Ht1079nh4UBEYOYDKI4C+4f15vJn5d4
   uPiL8lu2f0DP2eDdMCRzJAZAfQQSClS8Tla4uz5HQn/Dq+Sr5ue8hqF8l
   0Y+5mYcHkjoJK+M0zCd6ws340a/n1RMsP6ytw8MRW7Z97G2ZZmdNODeS7
   FTkCl5A+vdcXZMHd6BO2kajEyVuJZci5f0++/jlZlxhMfpoF/mW3Ors+N
   3rCN8jwQGYrUpK1XE9LbT9+kYG8FsOTlXaiIsqYpsw11ZnVhIPhSSACpf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="281813958"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="281813958"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 01:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="672294335"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2022 01:28:23 -0700
Date:   Mon, 29 Aug 2022 16:19:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 07/16] fpga: machxo2-spi: fix big-endianness
 incompatibility
Message-ID: <Ywx2eeTvBhNw62pW@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-8-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-8-j.zink@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-25 at 16:13:34 +0200, Johannes Zink wrote:
> The SPI message is written into the lowest-addressed bits of an
> unsigned long variable, but be32_to_cpu is called on the least
> significant bits of the variable. On big-endian 64-bit systems,
> this would give a wrong result. Fix this by using the fixed-size
> u32 instead of unsigned long. This clashes with the use of
> test_bit, which is unnecessary for a single u32 variable, so
> we adjust all usage sites appropriately and prefix the macros
> with MACHXO2_ while at it.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  drivers/fpga/machxo2-spi.c | 110 ++++++++++++++++++-------------------
>  1 file changed, 55 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> index 5e12612c7289..d1a8f28e04e7 100644
> --- a/drivers/fpga/machxo2-spi.c
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/bitfield.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> @@ -41,41 +42,40 @@
>  #define MACHXO2_BUF_SIZE		(MACHXO2_PAGE_SIZE + 4)
>  
>  /* Status register bits, errors and error mask */
> -#define BUSY	12
> -#define DONE	8
> -#define DVER	27
> -#define ENAB	9
> -#define ERRBITS	23
> -#define ERRMASK	7
> -#define FAIL	13
> -
> -#define ENOERR	0 /* no error */
> -#define EID	1
> -#define ECMD	2
> -#define ECRC	3
> -#define EPREAM	4 /* preamble error */
> -#define EABRT	5 /* abort error */
> -#define EOVERFL	6 /* overflow error */
> -#define ESDMEOF	7 /* SDM EOF */
> -
> -static inline u8 get_err(unsigned long *status)
> +#define MACHXO2_BUSY		BIT(12)
> +#define MACHXO2_DONE		BIT(8)
> +#define MACHXO2_DVER		BIT(27)
> +#define MACHXO2_ENAB		BIT(9)
> +#define MACHXO2_ERR		GENMASK(25, 23)
> +#define MACHXO2_ERR_ENOERR	0 /* no error */
> +#define MACHXO2_ERR_EID		1
> +#define MACHXO2_ERR_ECMD	2
> +#define MACHXO2_ERR_ECRC	3
> +#define MACHXO2_ERR_EPREAM	4 /* preamble error */
> +#define MACHXO2_ERR_EABRT	5 /* abort error */
> +#define MACHXO2_ERR_EOVERFL	6 /* overflow error */
> +#define MACHXO2_ERR_ESDMEOF	7 /* SDM EOF */
> +#define MACHXO2_FAIL		BIT(13)
> +
> +static inline u8 get_err(u32 status)
>  {
> -	return (*status >> ERRBITS) & ERRMASK;
> +	return FIELD_GET(MACHXO2_ERR, status);
>  }

So far the changes have nothing to do with the endian issue, is it? So
please put it into another patch.

>  
> -static int get_status(struct spi_device *spi, unsigned long *status)
> +static int get_status(struct spi_device *spi, u32 *status)
>  {
>  	struct spi_message msg;
>  	struct spi_transfer rx, tx;
>  	static const u8 cmd[] = LSC_READ_STATUS;
> +	__be32 tmp;
>  	int ret;
>  
>  	memset(&rx, 0, sizeof(rx));
>  	memset(&tx, 0, sizeof(tx));
>  	tx.tx_buf = cmd;
>  	tx.len = sizeof(cmd);
> -	rx.rx_buf = status;
> -	rx.len = 4;
> +	rx.rx_buf = &tmp;
> +	rx.len = sizeof(tmp);
>  	spi_message_init(&msg);
>  	spi_message_add_tail(&tx, &msg);
>  	spi_message_add_tail(&rx, &msg);
> @@ -83,7 +83,7 @@ static int get_status(struct spi_device *spi, unsigned long *status)
>  	if (ret)
>  		return ret;
>  
> -	*status = be32_to_cpu(*status);
> +	*status = be32_to_cpu(tmp);

Why not directly operate on the status, I don't see the difference.

>  
>  	return 0;
>  }
> @@ -91,30 +91,30 @@ static int get_status(struct spi_device *spi, unsigned long *status)
>  static const char *get_err_string(u8 err)
>  {
>  	switch (err) {
> -	case ENOERR:	return "No Error";
> -	case EID:	return "ID ERR";
> -	case ECMD:	return "CMD ERR";
> -	case ECRC:	return "CRC ERR";
> -	case EPREAM:	return "Preamble ERR";
> -	case EABRT:	return "Abort ERR";
> -	case EOVERFL:	return "Overflow ERR";
> -	case ESDMEOF:	return "SDM EOF";
> +	case MACHXO2_ERR_ENOERR:	return "No Error";
> +	case MACHXO2_ERR_EID:		return "ID ERR";
> +	case MACHXO2_ERR_ECMD:		return "CMD ERR";
> +	case MACHXO2_ERR_ECRC:		return "CRC ERR";
> +	case MACHXO2_ERR_EPREAM:	return "Preamble ERR";
> +	case MACHXO2_ERR_EABRT:		return "Abort ERR";
> +	case MACHXO2_ERR_EOVERFL:	return "Overflow ERR";
> +	case MACHXO2_ERR_ESDMEOF:	return "SDM EOF";
>  	}

Same concern, no relation to the commit message

>  
> -	return "Default switch case";
> +	return "Unknown";
>  }
>  
> -static void dump_status_reg(unsigned long *status)
> +static void dump_status_reg(u32 status)
>  {
> -	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> -		 *status, test_bit(DONE, status), test_bit(ENAB, status),
> -		 test_bit(BUSY, status), test_bit(FAIL, status),
> -		 test_bit(DVER, status), get_err_string(get_err(status)));
> +	pr_debug("machxo2 status: 0x%08X - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
> +		  status, !!FIELD_GET(MACHXO2_DONE, status), !!FIELD_GET(MACHXO2_ENAB, status),
> +		  !!FIELD_GET(MACHXO2_BUSY, status), !!FIELD_GET(MACHXO2_FAIL, status),
> +		  !!FIELD_GET(MACHXO2_DVER, status), get_err_string(get_err(status)));

Same concern. I'll not point out one by one below.

Thanks,
Yilun

>  }


>  
>  static int wait_until_not_busy(struct spi_device *spi)
>  {
> -	unsigned long status;
> +	u32 status;
>  	int ret, loop = 0;
>  
>  	do {
> @@ -123,7 +123,7 @@ static int wait_until_not_busy(struct spi_device *spi)
>  			return ret;
>  		if (++loop >= MACHXO2_MAX_BUSY_LOOP)
>  			return -EBUSY;
> -	} while (test_bit(BUSY, &status));
> +	} while (status & MACHXO2_BUSY);
>  
>  	return 0;
>  }
> @@ -169,14 +169,14 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
>  
>  static bool machxo2_status_done(unsigned long status)
>  {
> -	return !test_bit(BUSY, &status) && test_bit(DONE, &status) &&
> -		get_err(&status) == ENOERR;
> +	return (((status & (MACHXO2_BUSY | MACHXO2_DONE)) == MACHXO2_DONE) &&
> +		get_err(status) == MACHXO2_ERR_ENOERR);
>  }
>  
>  static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
>  {
>  	struct spi_device *spi = mgr->priv;
> -	unsigned long status;
> +	u32 status;
>  
>  	get_status(spi, &status);
>  	if (machxo2_status_done(status))
> @@ -195,7 +195,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
>  	static const u8 enable[] = ISC_ENABLE;
>  	static const u8 erase[] = ISC_ERASE;
>  	static const u8 initaddr[] = LSC_INITADDRESS;
> -	unsigned long status;
> +	u32 status;
>  	int ret;
>  
>  	if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> @@ -205,7 +205,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
>  	}
>  
>  	get_status(spi, &status);
> -	dump_status_reg(&status);
> +	dump_status_reg(status);
>  	memset(tx, 0, sizeof(tx));
>  	spi_message_init(&msg);
>  	tx[0].tx_buf = &enable;
> @@ -226,11 +226,11 @@ static int machxo2_write_init(struct fpga_manager *mgr,
>  		goto fail;
>  
>  	get_status(spi, &status);
> -	if (test_bit(FAIL, &status)) {
> +	if (status & MACHXO2_FAIL) {
>  		ret = -EINVAL;
>  		goto fail;
>  	}
> -	dump_status_reg(&status);
> +	dump_status_reg(status);
>  
>  	spi_message_init(&msg);
>  	tx[2].tx_buf = &initaddr;
> @@ -241,7 +241,7 @@ static int machxo2_write_init(struct fpga_manager *mgr,
>  		goto fail;
>  
>  	get_status(spi, &status);
> -	dump_status_reg(&status);
> +	dump_status_reg(status);
>  
>  	return 0;
>  fail:
> @@ -258,7 +258,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
>  	struct spi_transfer tx;
>  	static const u8 progincr[] = LSC_PROGINCRNV;
>  	u8 payload[MACHXO2_BUF_SIZE];
> -	unsigned long status;
> +	u32 status;
>  	int i, ret;
>  
>  	if (count % MACHXO2_PAGE_SIZE != 0) {
> @@ -266,7 +266,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
>  		return -EINVAL;
>  	}
>  	get_status(spi, &status);
> -	dump_status_reg(&status);
> +	dump_status_reg(status);
>  	memcpy(payload, &progincr, sizeof(progincr));
>  	for (i = 0; i < count; i += MACHXO2_PAGE_SIZE) {
>  		memcpy(&payload[sizeof(progincr)], &buf[i], MACHXO2_PAGE_SIZE);
> @@ -284,7 +284,7 @@ static int machxo2_write(struct fpga_manager *mgr, const char *buf,
>  		}
>  	}
>  	get_status(spi, &status);
> -	dump_status_reg(&status);
> +	dump_status_reg(status);
>  
>  	return 0;
>  }
> @@ -297,7 +297,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>  	struct spi_transfer tx[2];
>  	static const u8 progdone[] = ISC_PROGRAMDONE;
>  	static const u8 refresh[] = LSC_REFRESH;
> -	unsigned long status;
> +	u32 status;
>  	int ret, refreshloop = 0;
>  
>  	memset(tx, 0, sizeof(tx));
> @@ -313,8 +313,8 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>  		goto fail;
>  
>  	get_status(spi, &status);
> -	dump_status_reg(&status);
> -	if (!test_bit(DONE, &status)) {
> +	dump_status_reg(status);
> +	if (!(status & MACHXO2_DONE)) {
>  		machxo2_cleanup(mgr);
>  		ret = -EINVAL;
>  		goto fail;
> @@ -333,7 +333,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>  
>  		/* check refresh status */
>  		get_status(spi, &status);
> -		dump_status_reg(&status);
> +		dump_status_reg(status);
>  		if (machxo2_status_done(status))
>  			break;
>  		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
> @@ -344,7 +344,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>  	} while (1);
>  
>  	get_status(spi, &status);
> -	dump_status_reg(&status);
> +	dump_status_reg(status);
>  
>  	return 0;
>  fail:
> -- 
> 2.30.2
> 
