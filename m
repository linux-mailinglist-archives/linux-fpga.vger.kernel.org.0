Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94842680C1
	for <lists+linux-fpga@lfdr.de>; Sun, 14 Jul 2019 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfGNSkX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 14 Jul 2019 14:40:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34512 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNSkX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 14 Jul 2019 14:40:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so7192918plt.1;
        Sun, 14 Jul 2019 11:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3QvkgyeZBwQAFK6xEzLnSHFLAtsVg3BWcWG42Z3ly8c=;
        b=Ce6cP/XIVMuSrX1pb59J1RrqbhTpGSTZWZRB65Stk85b5akkzsPJIjveVSH40TiCZp
         lzp0KdJNByt+UJsRUOdwb+tL5FaS2F23TKd9fDE/ETuf9fwPwRMQpvzRBhefTdDYJeby
         SaQTJSsuazNspV4iWSmlq75nzGwecbne2tSO6WYZhKSVfYvmyHnowyk3ZPBjuNS7TyDP
         l37yY7kVX+kQrwhVZkRUKLnyZMzUX0CbEwIHt3/sqOh9bEa0fXXosMNuwECnWIBmJXoB
         +NVYeLPC4DeYrbiHj53bnxfnrT8mCCOj9yArl3VQooYJg6sgE8Dplk9qRkmVrF6BOQHA
         f8Ng==
X-Gm-Message-State: APjAAAWkrkKaLCpejVYjRWlkcSJXLCNIWtXoW4CNlTTvOT6BdcnjdqOo
        2zoBFaAJ0TCIJny4axtNpkc=
X-Google-Smtp-Source: APXvYqw7/OXuCgKL70cz/PefTE85jMyChYFO/b3I22EMic9qj54l6el1V5x/FCwGBWz1b/S0awkFNw==
X-Received: by 2002:a17:902:7c90:: with SMTP id y16mr24415803pll.238.1563129622039;
        Sun, 14 Jul 2019 11:40:22 -0700 (PDT)
Received: from localhost (c-73-15-170-202.hsd1.ca.comcast.net. [73.15.170.202])
        by smtp.gmail.com with ESMTPSA id h1sm18256148pfg.55.2019.07.14.11.40.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 11:40:21 -0700 (PDT)
Date:   Sun, 14 Jul 2019 11:40:19 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fpga: altera-cvp: Discover Vendor Specific offset
Message-ID: <20190714184019.GA9048@archbook>
References: <1562877170-23931-1-git-send-email-thor.thayer@linux.intel.com>
 <1562877170-23931-2-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562877170-23931-2-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 11, 2019 at 03:32:48PM -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Newer Intel FPGAs have different Vendor Specific offsets than
> legacy parts. Use PCI discovery to find the CvP registers.
> Since the register positions remain the same, change the hard
> coded address to a more flexible way of indexing registers
> from the offset.
> Adding new PCI read and write abstraction functions to
> handle the offset (altera_read_config_dword() and
> altera_write_config_dword()).
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/fpga/altera-cvp.c | 91 +++++++++++++++++++++++++++++------------------
>  1 file changed, 56 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 770915fb97f9..04f2b2a072a7 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -22,10 +22,10 @@
>  #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
>  
>  /* Vendor Specific Extended Capability Registers */
> -#define VSE_PCIE_EXT_CAP_ID		0x200
> +#define VSE_PCIE_EXT_CAP_ID		0x0
>  #define VSE_PCIE_EXT_CAP_ID_VAL		0x000b	/* 16bit */
>  
> -#define VSE_CVP_STATUS			0x21c	/* 32bit */
> +#define VSE_CVP_STATUS			0x1c	/* 32bit */
>  #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
>  #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
>  #define VSE_CVP_STATUS_CVP_EN		BIT(20)	/* ctrl block is enabling CVP */
> @@ -33,18 +33,18 @@
>  #define VSE_CVP_STATUS_CFG_DONE		BIT(23)	/* CVP_CONFIG_DONE */
>  #define VSE_CVP_STATUS_PLD_CLK_IN_USE	BIT(24)	/* PLD_CLK_IN_USE */
>  
> -#define VSE_CVP_MODE_CTRL		0x220	/* 32bit */
> +#define VSE_CVP_MODE_CTRL		0x20	/* 32bit */
>  #define VSE_CVP_MODE_CTRL_CVP_MODE	BIT(0)	/* CVP (1) or normal mode (0) */
>  #define VSE_CVP_MODE_CTRL_HIP_CLK_SEL	BIT(1) /* PMA (1) or fabric clock (0) */
>  #define VSE_CVP_MODE_CTRL_NUMCLKS_OFF	8	/* NUMCLKS bits offset */
>  #define VSE_CVP_MODE_CTRL_NUMCLKS_MASK	GENMASK(15, 8)
>  
> -#define VSE_CVP_DATA			0x228	/* 32bit */
> -#define VSE_CVP_PROG_CTRL		0x22c	/* 32bit */
> +#define VSE_CVP_DATA			0x28	/* 32bit */
> +#define VSE_CVP_PROG_CTRL		0x2c	/* 32bit */
>  #define VSE_CVP_PROG_CTRL_CONFIG	BIT(0)
>  #define VSE_CVP_PROG_CTRL_START_XFER	BIT(1)
>  
> -#define VSE_UNCOR_ERR_STATUS		0x234	/* 32bit */
> +#define VSE_UNCOR_ERR_STATUS		0x34	/* 32bit */
>  #define VSE_UNCOR_ERR_CVP_CFG_ERR	BIT(5)	/* CVP_CONFIG_ERROR_LATCHED */
>  
>  #define DRV_NAME		"altera-cvp"
> @@ -60,14 +60,27 @@ struct altera_cvp_conf {
>  	void			(*write_data)(struct altera_cvp_conf *, u32);
>  	char			mgr_name[64];
>  	u8			numclks;
> +	u32			vsec_offset;
>  };
>  
> +static inline void altera_read_config_dword(struct altera_cvp_conf *conf,
> +					    int where, u32 *val)
> +{
> +	pci_read_config_dword(conf->pci_dev, conf->vsec_offset + where, val);
> +}

I think the compiler would inline those anyway.
> +
> +static inline void altera_write_config_dword(struct altera_cvp_conf *conf,
> +					     int where, u32 val)
> +{
> +	pci_write_config_dword(conf->pci_dev, conf->vsec_offset + where, val);
> +}

I think the compiler would inline those anyway.
> +
>  static enum fpga_mgr_states altera_cvp_state(struct fpga_manager *mgr)
>  {
>  	struct altera_cvp_conf *conf = mgr->priv;
>  	u32 status;
>  
> -	pci_read_config_dword(conf->pci_dev, VSE_CVP_STATUS, &status);
> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &status);
>  
>  	if (status & VSE_CVP_STATUS_CFG_DONE)
>  		return FPGA_MGR_STATE_OPERATING;
> @@ -85,7 +98,8 @@ static void altera_cvp_write_data_iomem(struct altera_cvp_conf *conf, u32 val)
>  
>  static void altera_cvp_write_data_config(struct altera_cvp_conf *conf, u32 val)
>  {
> -	pci_write_config_dword(conf->pci_dev, VSE_CVP_DATA, val);
> +	pci_write_config_dword(conf->pci_dev, conf->vsec_offset + VSE_CVP_DATA,
> +			       val);
>  }
>  
>  /* switches between CvP clock and internal clock */
> @@ -95,10 +109,10 @@ static void altera_cvp_dummy_write(struct altera_cvp_conf *conf)
>  	u32 val;
>  
>  	/* set 1 CVP clock cycle for every CVP Data Register Write */
> -	pci_read_config_dword(conf->pci_dev, VSE_CVP_MODE_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
>  	val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
>  	val |= 1 << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
> -	pci_write_config_dword(conf->pci_dev, VSE_CVP_MODE_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
>  
>  	for (i = 0; i < CVP_DUMMY_WR; i++)
>  		conf->write_data(conf, 0); /* dummy data, could be any value */
> @@ -115,7 +129,7 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
>  		retries++;
>  
>  	do {
> -		pci_read_config_dword(conf->pci_dev, VSE_CVP_STATUS, &val);
> +		altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>  		if ((val & status_mask) == status_val)
>  			return 0;
>  
> @@ -130,18 +144,17 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>  			       struct fpga_image_info *info)
>  {
>  	struct altera_cvp_conf *conf = mgr->priv;
> -	struct pci_dev *pdev = conf->pci_dev;
>  	int ret;
>  	u32 val;
>  
>  	/* STEP 12 - reset START_XFER bit */
> -	pci_read_config_dword(pdev, VSE_CVP_PROG_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
>  	val &= ~VSE_CVP_PROG_CTRL_START_XFER;
> -	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
>  
>  	/* STEP 13 - reset CVP_CONFIG bit */
>  	val &= ~VSE_CVP_PROG_CTRL_CONFIG;
> -	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
>  
>  	/*
>  	 * STEP 14
> @@ -163,7 +176,6 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  				 const char *buf, size_t count)
>  {
>  	struct altera_cvp_conf *conf = mgr->priv;
> -	struct pci_dev *pdev = conf->pci_dev;
>  	u32 iflags, val;
>  	int ret;
>  
> @@ -183,7 +195,7 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  		conf->numclks = 1; /* for uncompressed and unencrypted images */
>  
>  	/* STEP 1 - read CVP status and check CVP_EN flag */
> -	pci_read_config_dword(pdev, VSE_CVP_STATUS, &val);
> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>  	if (!(val & VSE_CVP_STATUS_CVP_EN)) {
>  		dev_err(&mgr->dev, "CVP mode off: 0x%04x\n", val);
>  		return -ENODEV;
> @@ -201,14 +213,14 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	 * - set HIP_CLK_SEL and CVP_MODE (must be set in the order mentioned)
>  	 */
>  	/* switch from fabric to PMA clock */
> -	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
>  	val |= VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> -	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
>  
>  	/* set CVP mode */
> -	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
>  	val |= VSE_CVP_MODE_CTRL_CVP_MODE;
> -	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
>  
>  	/*
>  	 * STEP 3
> @@ -217,10 +229,10 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	altera_cvp_dummy_write(conf);
>  
>  	/* STEP 4 - set CVP_CONFIG bit */
> -	pci_read_config_dword(pdev, VSE_CVP_PROG_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
>  	/* request control block to begin transfer using CVP */
>  	val |= VSE_CVP_PROG_CTRL_CONFIG;
> -	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
>  
>  	/* STEP 5 - poll CVP_CONFIG READY for 1 with 10us timeout */
>  	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY,
> @@ -237,15 +249,15 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>  	altera_cvp_dummy_write(conf);
>  
>  	/* STEP 7 - set START_XFER */
> -	pci_read_config_dword(pdev, VSE_CVP_PROG_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_PROG_CTRL, &val);
>  	val |= VSE_CVP_PROG_CTRL_START_XFER;
> -	pci_write_config_dword(pdev, VSE_CVP_PROG_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_PROG_CTRL, val);
>  
>  	/* STEP 8 - start transfer (set CVP_NUMCLKS for bitstream) */
> -	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
>  	val &= ~VSE_CVP_MODE_CTRL_NUMCLKS_MASK;
>  	val |= conf->numclks << VSE_CVP_MODE_CTRL_NUMCLKS_OFF;
> -	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
>  
>  	return 0;
>  }
> @@ -256,7 +268,7 @@ static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
>  	u32 val;
>  
>  	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> -	pci_read_config_dword(conf->pci_dev, VSE_CVP_STATUS, &val);
> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>  	if (val & VSE_CVP_STATUS_CFG_ERR) {
>  		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
>  			bytes);
> @@ -315,7 +327,6 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>  				     struct fpga_image_info *info)
>  {
>  	struct altera_cvp_conf *conf = mgr->priv;
> -	struct pci_dev *pdev = conf->pci_dev;
>  	int ret;
>  	u32 mask;
>  	u32 val;
> @@ -325,17 +336,17 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>  		return ret;
>  
>  	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
> -	pci_read_config_dword(pdev, VSE_UNCOR_ERR_STATUS, &val);
> +	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
>  	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
>  		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
>  		return -EPROTO;
>  	}
>  
>  	/* STEP 17 - reset CVP_MODE and HIP_CLK_SEL bit */
> -	pci_read_config_dword(pdev, VSE_CVP_MODE_CTRL, &val);
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
>  	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
>  	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> -	pci_write_config_dword(pdev, VSE_CVP_MODE_CTRL, val);
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
>  
>  	/* STEP 18 - poll PLD_CLK_IN_USE and USER_MODE bits */
>  	mask = VSE_CVP_STATUS_PLD_CLK_IN_USE | VSE_CVP_STATUS_USERMODE;
> @@ -396,20 +407,27 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	struct fpga_manager *mgr;
>  	u16 cmd, val;
>  	u32 regval;
> -	int ret;
> +	int ret, offset;

Reverse tree, please:
  	struct fpga_manager *mgr;
 +	int ret, offset;
  	u16 cmd, val;
  	u32 regval;
 -	int ret;

> +
> +	/* Discover the Vendor Specific Offset for this device */
> +	offset = pci_find_next_ext_capability(pdev, 0, PCI_EXT_CAP_ID_VNDR);
> +	if (!offset) {
> +		dev_err(&pdev->dev, "No Vendor Specific Offset.\n");
> +		return -ENODEV;
> +	}
>  
>  	/*
>  	 * First check if this is the expected FPGA device. PCI config
>  	 * space access works without enabling the PCI device, memory
>  	 * space access is enabled further down.
>  	 */
> -	pci_read_config_word(pdev, VSE_PCIE_EXT_CAP_ID, &val);
> +	pci_read_config_word(pdev, offset + VSE_PCIE_EXT_CAP_ID, &val);
>  	if (val != VSE_PCIE_EXT_CAP_ID_VAL) {
>  		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value 0x%x\n", val);
>  		return -ENODEV;
>  	}
>  
> -	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
> +	pci_read_config_dword(pdev, offset + VSE_CVP_STATUS, &regval);
>  	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
>  		dev_err(&pdev->dev,
>  			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
> @@ -421,6 +439,9 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	if (!conf)
>  		return -ENOMEM;
>  
> +	conf->vsec_offset = offset;

If you'd swap the order you could use your new helper earlier, right?
not sure if that saves you some code. Your call.

> +	dev_dbg(&pdev->dev, "Vendor Specific Data Offset at 0x%x\n", offset);
> +
>  	/*
>  	 * Enable memory BAR access. We cannot use pci_enable_device() here
>  	 * because it will make the driver unusable with FPGA devices that
> -- 
> 2.7.4
> 

Thanks,
Moritz
