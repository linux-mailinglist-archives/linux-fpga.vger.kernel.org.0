Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E651C4D237C
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 22:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiCHVlO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 16:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241520AbiCHVlN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 16:41:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF3A4EF65;
        Tue,  8 Mar 2022 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=I8yzHC1Xlo807W/LcczI8zaHBKgBK4Z74fr7+DrjB6Y=; b=MMoZWDf3F66bBjPZVjjfcy9ed8
        +n5IRnJJoId3VMNStIS2o8v5OfttlDumunSYftyBazUO0R/vije/CuTgxuRmyxdwlsKVGGTFWsM9q
        fK9orsfvTrmtaHQRcpAIy1Ccy7kR69sFhLrg5hnoRTLWk5Q4xz1uaR0YnR6XmZrspbqjPjqMznb1w
        wWqhSDrClS7H7dBWeXUsVSXIOUlSKwoXLiIem1b589OFmpx64AdWemDNR2aiRfqdfckEDKbIqC89K
        ycp2lmnNqICtsMvO3/6RGPbZW/CbFTAMoNXGVNcVB3cTsbTuDLrUcDGCGiVGtY+6Bh3+8dSnQHRsZ
        DrIHgv+A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRhYw-00GYmR-2r; Tue, 08 Mar 2022 21:40:10 +0000
Message-ID: <6d3bca5e-00d7-3a69-4f90-809f4aac95d5@infradead.org>
Date:   Tue, 8 Mar 2022 13:40:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 6/6] fpga: fpga-region: Add missing kernel-doc description
Content-Language: en-US
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
 <20220308094519.1816649-7-nava.manne@xilinx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220308094519.1816649-7-nava.manne@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

For all function return results,

s/@return:/Return:/

thanks.

On 3/8/22 01:45, Nava kishore Manne wrote:
> Fixed the warnings: Function parameter or member 'xxx' not
> described.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/of-fpga-region.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 50b83057c048..61ce257c47f3 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -28,7 +28,7 @@ MODULE_DEVICE_TABLE(of, fpga_region_of_match);
>   *
>   * Caller will need to put_device(&region->dev) when done.
>   *
> - * Returns FPGA Region struct or NULL
> + * @return: FPGA Region struct or NULL
>   */
>  static struct fpga_region *of_fpga_region_find(struct device_node *np)
>  {
> @@ -43,7 +43,7 @@ static struct fpga_region *of_fpga_region_find(struct device_node *np)
>   *
>   * Caller should call fpga_mgr_put() when done with manager.
>   *
> - * Return: fpga manager struct or IS_ERR() condition containing error code.
> + * @return: fpga manager struct or IS_ERR() condition containing error code.
>   */
>  static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
>  {
> @@ -80,7 +80,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
>   * Caller should call fpga_bridges_put(&region->bridge_list) when
>   * done with the bridges.
>   *
> - * Return 0 for success (even if there are no bridges specified)
> + * @return: 0 for success (even if there are no bridges specified)
>   * or -EBUSY if any of the bridges are in use.
>   */
>  static int of_fpga_region_get_bridges(struct fpga_region *region)
> @@ -139,13 +139,13 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
>  }
>  
>  /**
> - * child_regions_with_firmware
> + * child_regions_with_firmware - Used to check the child region info.
>   * @overlay: device node of the overlay
>   *
>   * If the overlay adds child FPGA regions, they are not allowed to have
>   * firmware-name property.
>   *
> - * Return 0 for OK or -EINVAL if child FPGA region adds firmware-name.
> + * @return: 0 for OK or -EINVAL if child FPGA region adds firmware-name.
>   */
>  static int child_regions_with_firmware(struct device_node *overlay)
>  {
> @@ -184,7 +184,7 @@ static int child_regions_with_firmware(struct device_node *overlay)
>   * Given an overlay applied to an FPGA region, parse the FPGA image specific
>   * info in the overlay and do some checking.
>   *
> - * Returns:
> + * @return:
>   *   NULL if overlay doesn't direct us to program the FPGA.
>   *   fpga_image_info struct if there is an image to program.
>   *   error code for invalid overlay.
> @@ -279,7 +279,7 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
>   * If the checks fail, overlay is rejected and does not get added to the
>   * live tree.
>   *
> - * Returns 0 for success or negative error code for failure.
> + * @return: 0 for success or negative error code for failure.
>   */
>  static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
>  					   struct of_overlay_notify_data *nd)
> @@ -339,7 +339,7 @@ static void of_fpga_region_notify_post_remove(struct fpga_region *region,
>   * This notifier handles programming an FPGA when a "firmware-name" property is
>   * added to an fpga-region.
>   *
> - * Returns NOTIFY_OK or error if FPGA programming fails.
> + * @return: NOTIFY_OK or error if FPGA programming fails.
>   */
>  static int of_fpga_region_notify(struct notifier_block *nb,
>  				 unsigned long action, void *arg)
> @@ -446,6 +446,8 @@ static struct platform_driver of_fpga_region_driver = {
>  /**
>   * of_fpga_region_init - init function for fpga_region class
>   * Creates the fpga_region class and registers a reconfig notifier.
> + *
> + * @return: 0 on success, negative error code otherwise.
>   */
>  static int __init of_fpga_region_init(void)
>  {

-- 
~Randy
