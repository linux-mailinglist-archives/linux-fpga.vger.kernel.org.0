Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F818658EE2
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 17:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiL2QTI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 11:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiL2QTG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 11:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B21276D
        for <linux-fpga@vger.kernel.org>; Thu, 29 Dec 2022 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672330690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cTT31HTvGe+Qe8n5FI5dXXO0PvHOsuqL6uctOPRNNQ=;
        b=AilFwYkWv2eNt2oGzwPapslCA2/jhV+FOltTlg5wvzRb88e3CXhRHgk40HSFc4ZgOJNim1
        UiopCGBb1kNogX2juk9MW2mX4x44LefkiI04SmW5EWUTi1NLobhmVy2nn4aJt5g6k2tY7e
        tby7flzVU5obDrG1eXJWEdRm4X4+c+c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-ON9QZbYtOvqs0EHwE-4qKg-1; Thu, 29 Dec 2022 11:18:09 -0500
X-MC-Unique: ON9QZbYtOvqs0EHwE-4qKg-1
Received: by mail-qk1-f197.google.com with SMTP id x12-20020a05620a258c00b007051ae500a2so2502688qko.15
        for <linux-fpga@vger.kernel.org>; Thu, 29 Dec 2022 08:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cTT31HTvGe+Qe8n5FI5dXXO0PvHOsuqL6uctOPRNNQ=;
        b=GZyahgqbdr2N3v16Af8RK/XjwQJmQ4G6eaJjR+GViMYGDPqYrf32wCePFBQOu4KmEM
         abVasvySNhrKRajUskIDEZLPXKtg3egT1lm77+YIwgmWcbtuX5LQqqGiOE8q0+w39ZRt
         +uJjNuY/y/LDO+/Sn12znfILXujCjnwd9Epb5+3/N/CCjibjImxCJ0ZQhtf08huahuja
         h0Cqhx1oaVH7Mj5WgDRthizEWzEvlW1OfUT2slcs1Ii0yOQhnIHIXyGSU+E/uWQfi+hn
         6T6k/k6RI0CpJuYAl7+O7Z58zS8g1rZxSYiYmIZBJJNbVP45z8nUEQYRXvX+zs3O8JEk
         21BQ==
X-Gm-Message-State: AFqh2krz2Od9rLYLbi5CLKDP5K1ddQYIzV7CwCIe8u3Vk4pLyLh/93bJ
        aFwjrjElXvraUrvrbMKzt19X/j8bljlLzYlF++q96mn1fJQRpDdvOS4WOQYRiYcAewgepWr5RA3
        mL/v8Uq7POGk1P/YljjhEPg==
X-Received: by 2002:ac8:6ec4:0:b0:3a8:1fde:a394 with SMTP id f4-20020ac86ec4000000b003a81fdea394mr38243155qtv.59.1672330688456;
        Thu, 29 Dec 2022 08:18:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtUVx95SHC77nYwI2gNOyrd4kpfPBqQGccAgjJb+pvs4HiX6yCp9NU0cNSHtUauAkLEXrfOfA==
X-Received: by 2002:ac8:6ec4:0:b0:3a8:1fde:a394 with SMTP id f4-20020ac86ec4000000b003a81fdea394mr38243122qtv.59.1672330688081;
        Thu, 29 Dec 2022 08:18:08 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id j3-20020ac85503000000b003ab43dabfb1sm11733306qtq.55.2022.12.29.08.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 08:18:07 -0800 (PST)
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianfei.zhang@intel.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        linux-serial@vger.kernel.org, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com>
 <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com>
Date:   Thu, 29 Dec 2022 08:18:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Version 1 of the Device Feature Header (DFH) definition adds
> functionality to the DFL bus.
>
> A DFHv1 header may have one or more parameter blocks that
> further describes the HW to SW.  Add support to the DFL bus
> to parse the MSI-X parameter.
>
> The location of a feature's register set is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> v8: use struct_size() from overflow.h
>      add dfh_get_u64_param_vals()
>
> v7: no change
>
> v6: move MSI_X parameter definitions to drivers/fpga/dfl.h
>
> v5: update field names
>      fix find_param/dfh_get_psize
>      clean up mmio_res assignments
>      use u64* instead of void*
>      use FIELD_GET instead of masking
>
> v4: s/MSIX/MSI_X
>      move kernel doc to implementation
>      use structure assignment
>      fix decode of absolute address
>      clean up comment in parse_feature_irqs
>      remove use of csr_res
>
> v3: remove unneeded blank line
>      use clearer variable name
>      pass finfo into parse_feature_irqs()
>      refactor code for better indentation
>      use switch statement for irq parsing
>      squash in code parsing register location
>
> v2: fix kernel doc
>      clarify use of DFH_VERSION field
> ---
>   drivers/fpga/dfl.c  | 265 +++++++++++++++++++++++++++++++++++---------
>   drivers/fpga/dfl.h  |   9 ++
>   include/linux/dfl.h |   6 +
>   3 files changed, 229 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b9aae85ba930..403fa425c1fe 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -13,6 +13,7 @@
>   #include <linux/dfl.h>
>   #include <linux/fpga-dfl.h>
>   #include <linux/module.h>
> +#include <linux/overflow.h>
>   #include <linux/uaccess.h>
>   
>   #include "dfl.h"
> @@ -342,6 +343,8 @@ static void release_dfl_dev(struct device *dev)
>   	if (ddev->mmio_res.parent)
>   		release_resource(&ddev->mmio_res);
>   
> +	kfree(ddev->params);
> +
>   	ida_free(&dfl_device_ida, ddev->id);
>   	kfree(ddev->irqs);
>   	kfree(ddev);
> @@ -380,7 +383,16 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
>   	ddev->type = feature_dev_id_type(pdev);
>   	ddev->feature_id = feature->id;
>   	ddev->revision = feature->revision;
> +	ddev->dfh_version = feature->dfh_version;
>   	ddev->cdev = pdata->dfl_cdev;
> +	if (feature->param_size) {
> +		ddev->params = kmemdup(feature->params, feature->param_size, GFP_KERNEL);
> +		if (!ddev->params) {
> +			ret = -ENOMEM;
> +			goto put_dev;
> +		}
> +		ddev->param_size = feature->param_size;
> +	}
>   
>   	/* add mmio resource */
>   	parent_res = &pdev->resource[feature->resource_index];
> @@ -708,20 +720,27 @@ struct build_feature_devs_info {
>    * struct dfl_feature_info - sub feature info collected during feature dev build
>    *
>    * @fid: id of this sub feature.
> + * @revision: revision of this sub feature
> + * @dfh_version: version of Device Feature Header (DFH)
>    * @mmio_res: mmio resource of this sub feature.
>    * @ioaddr: mapped base address of mmio resource.
>    * @node: node in sub_features linked list.
>    * @irq_base: start of irq index in this sub feature.
>    * @nr_irqs: number of irqs of this sub feature.
> + * @param_size: size DFH parameters.
> + * @params: DFH parameter data.
>    */
>   struct dfl_feature_info {
>   	u16 fid;
>   	u8 revision;
> +	u8 dfh_version;
>   	struct resource mmio_res;
>   	void __iomem *ioaddr;
>   	struct list_head node;
>   	unsigned int irq_base;
>   	unsigned int nr_irqs;
> +	unsigned int param_size;
> +	u64 params[];
u64 *params
>   };
>   
>   static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
> @@ -797,7 +816,17 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>   		feature->dev = fdev;
>   		feature->id = finfo->fid;
>   		feature->revision = finfo->revision;
> +		feature->dfh_version = finfo->dfh_version;
>   
> +		if (finfo->param_size) {
> +			feature->params = devm_kmemdup(binfo->dev,
> +						       finfo->params, finfo->param_size,
> +						       GFP_KERNEL);
> +			if (!feature->params)
> +				return -ENOMEM;
> +
> +			feature->param_size = finfo->param_size;
> +		}
>   		/*
>   		 * the FIU header feature has some fundamental functions (sriov
>   		 * set, port enable/disable) needed for the dfl bus device and
> @@ -934,56 +963,135 @@ static u16 feature_id(u64 value)
>   	return 0;
>   }
>   
> +static u64 *find_param(u64 *params, resource_size_t max, int param_id)
> +{
> +	u64 *end = params + max / sizeof(u64);
> +	u64 v, next;
> +
> +	while (params < end) {
> +		v = *params;
> +		if (param_id == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return params;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		params += next;
> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
> +			break;
Move before next =, and save some work calculating unsed next
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * dfh_find_param() - find parameter block for the given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + *
> + * Return: pointer to start of parameter block, NULL otherwise.
> + */
> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id)
> +{
> +	return find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +}
> +EXPORT_SYMBOL_GPL(dfh_find_param);

This and similar should be noop's for dfh v0

Generally there should be better checking if code is running a v1 vs  v0 
header.

> +
> +/**
> + * dfh_get_u64_param_vals() - get array of u64 param values for given parameter id
> + * @dfl_dev: dfl device
> + * @param: id of dfl parameter
> + * @pval: location of parameter data destination
> + * @nvals: number of u64 elements of parameter data
> + *
> + * Return: pointer to start of parameter block, PTR_ERR otherwise
> + */
> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 *pval, int nvals)
nvals should be unsigned
> +{
> +	u64 *param = find_param(dfl_dev->params, dfl_dev->param_size, param_id);
> +	u64 next;
> +	int i;
> +
> +	if (!param)
> +		return ERR_PTR(-ENOENT);
> +
> +	next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, *param);
> +
> +	if (nvals >= next)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < nvals; i++)
> +		*pval++ = param[i + 1];
memcpy ?
> +
> +	return param;
> +}
> +EXPORT_SYMBOL_GPL(dfh_get_u64_param_vals);
> +
>   static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> -			      resource_size_t ofst, u16 fid,
> -			      unsigned int *irq_base, unsigned int *nr_irqs)
> +			      resource_size_t ofst, struct dfl_feature_info *finfo)
>   {
>   	void __iomem *base = binfo->ioaddr + ofst;
>   	unsigned int i, ibase, inr = 0;
> +	void *params = finfo->params;
>   	enum dfl_id_type type;
> +	u16 fid = finfo->fid;
>   	int virq;
> +	u64 *p;
>   	u64 v;
>   
> -	type = feature_dev_id_type(binfo->feature_dev);
> +	switch (finfo->dfh_version) {
> +	case 0:

A switch makes this code complicated to read.

Have you thought about a function pointer table to separate out similar 
v1 vs v0 code blocks?

> +		/*
> +		 * DFHv0 only provides MMIO resource information for each feature
> +		 * in the DFL header.  There is no generic interrupt information.
> +		 * Instead, features with interrupt functionality provide
> +		 * the information in feature specific registers.
> +		 */
> +		type = feature_dev_id_type(binfo->feature_dev);
> +		if (type == PORT_ID) {
> +			switch (fid) {
> +			case PORT_FEATURE_ID_UINT:
> +				v = readq(base + PORT_UINT_CAP);
> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +				break;
> +			case PORT_FEATURE_ID_ERROR:
> +				v = readq(base + PORT_ERROR_CAP);
> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +				break;
> +			}
> +		} else if (type == FME_ID) {
> +			switch (fid) {
> +			case FME_FEATURE_ID_GLOBAL_ERR:
> +				v = readq(base + FME_ERROR_CAP);
> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +				break;
> +			}
> +		}
> +		break;
>   
> -	/*
> -	 * Ideally DFL framework should only read info from DFL header, but
> -	 * current version DFL only provides mmio resources information for
> -	 * each feature in DFL Header, no field for interrupt resources.
> -	 * Interrupt resource information is provided by specific mmio
> -	 * registers of each private feature which supports interrupt. So in
> -	 * order to parse and assign irq resources, DFL framework has to look
> -	 * into specific capability registers of these private features.
> -	 *
> -	 * Once future DFL version supports generic interrupt resource
> -	 * information in common DFL headers, the generic interrupt parsing
> -	 * code will be added. But in order to be compatible to old version
> -	 * DFL, the driver may still fall back to these quirks.
> -	 */
> -	if (type == PORT_ID) {
> -		switch (fid) {
> -		case PORT_FEATURE_ID_UINT:
> -			v = readq(base + PORT_UINT_CAP);
> -			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> -			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> -			break;
> -		case PORT_FEATURE_ID_ERROR:
> -			v = readq(base + PORT_ERROR_CAP);
> -			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> -			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +	case 1:
> +		/*
> +		 * DFHv1 provides interrupt resource information in DFHv1
> +		 * parameter blocks.
> +		 */
> +		p = find_param(params, finfo->param_size, DFHv1_PARAM_ID_MSI_X);
> +		if (!p)
>   			break;
> -		}
> -	} else if (type == FME_ID) {
> -		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
> -			v = readq(base + FME_ERROR_CAP);
> -			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> -			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> -		}
> +
> +		p++;
> +		ibase = FIELD_GET(DFHv1_PARAM_MSI_X_STARTV, *p);
> +		inr = FIELD_GET(DFHv1_PARAM_MSI_X_NUMV, *p);
> +		break;
> +
> +	default:
> +		dev_warn(binfo->dev, "unexpected DFH version %d\n", finfo->dfh_version);
> +		break;
>   	}
>   
>   	if (!inr) {
> -		*irq_base = 0;
> -		*nr_irqs = 0;
> +		finfo->irq_base = 0;
> +		finfo->nr_irqs = 0;
>   		return 0;
>   	}
>   
> @@ -1006,12 +1114,37 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>   		}
>   	}
>   
> -	*irq_base = ibase;
> -	*nr_irqs = inr;
> +	finfo->irq_base = ibase;
> +	finfo->nr_irqs = inr;
>   
>   	return 0;
>   }
>   
> +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
for clarity, psize should be expanded to param_size
> +{
> +	int size = 0;
> +	u64 v, next;
> +
> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
> +		return 0;
> +
> +	while (size + DFHv1_PARAM_HDR < max) {
> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		if (!next)
> +			return -EINVAL;
> +
> +		size += next * sizeof(u64);
> +
> +		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
> +			return size;
> +	}
> +
> +	return -ENOENT;
> +}
> +
>   /*
>    * when create sub feature instances, for private features, it doesn't need
>    * to provide resource size and feature id as they could be read from DFH
> @@ -1023,39 +1156,69 @@ static int
>   create_feature_instance(struct build_feature_devs_info *binfo,
>   			resource_size_t ofst, resource_size_t size, u16 fid)
>   {
> -	unsigned int irq_base, nr_irqs;
>   	struct dfl_feature_info *finfo;
> +	resource_size_t start, end;
> +	int dfh_psize = 0;
>   	u8 revision = 0;
> +	u64 v, addr_off;
> +	u8 dfh_ver = 0;
>   	int ret;
> -	u64 v;
>   
>   	if (fid != FEATURE_ID_AFU) {
>   		v = readq(binfo->ioaddr + ofst);
>   		revision = FIELD_GET(DFH_REVISION, v);
> -
> +		dfh_ver = FIELD_GET(DFH_VERSION, v);
>   		/* read feature size and id if inputs are invalid */
>   		size = size ? size : feature_size(v);
>   		fid = fid ? fid : feature_id(v);
> +		if (dfh_ver == 1) {
> +			dfh_psize = dfh_get_psize(binfo->ioaddr + ofst, size);
> +			if (dfh_psize < 0) {
> +				dev_err(binfo->dev,
> +					"failed to read size of DFHv1 parameters %d\n",
> +					dfh_psize);
> +				return dfh_psize;
> +			}
> +			dev_dbg(binfo->dev, "dfhv1_psize %d\n", dfh_psize);
> +		}
>   	}
>   
>   	if (binfo->len - ofst < size)
>   		return -EINVAL;
>   
> -	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> -	if (ret)
> -		return ret;
> -
> -	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
> +	finfo = kzalloc(struct_size(finfo, params, dfh_psize/sizeof(u64)), GFP_KERNEL);
>   	if (!finfo)
>   		return -ENOMEM;
>   
> +	memcpy_fromio(finfo->params, binfo->ioaddr + ofst + DFHv1_PARAM_HDR, dfh_psize);
> +	finfo->param_size = dfh_psize;
> +
>   	finfo->fid = fid;
>   	finfo->revision = revision;
> -	finfo->mmio_res.start = binfo->start + ofst;
> -	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> +	finfo->dfh_version = dfh_ver;
> +	if (dfh_ver == 1) {
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
> +		addr_off = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +		if (FIELD_GET(DFHv1_CSR_ADDR_REL, v))
> +			start = addr_off << 1;
> +		else
> +			start = binfo->start + ofst + addr_off;
> +
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
> +		end = start + FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
> +	} else {
> +		start = binfo->start + ofst;
> +		end = start + size - 1;
> +	}
>   	finfo->mmio_res.flags = IORESOURCE_MEM;
> -	finfo->irq_base = irq_base;
> -	finfo->nr_irqs = nr_irqs;
> +	finfo->mmio_res.start = start;
> +	finfo->mmio_res.end = end;
> +
> +	ret = parse_feature_irqs(binfo, ofst, finfo);
> +	if (ret) {
> +		kfree(finfo);
> +		return ret;
> +	}
>   
>   	list_add_tail(&finfo->node, &binfo->sub_features);
>   	binfo->feature_num++;
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index fc59f33367ee..a21065cec04e 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -111,6 +111,10 @@
>   #define DFHv1_PARAM_HDR_NEXT_EOP	BIT_ULL(32)
>   #define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
>   
> +#define DFHv1_PARAM_ID_MSI_X		0x1
> +#define DFHv1_PARAM_MSI_X_NUMV		GENMASK_ULL(63, 32)
> +#define DFHv1_PARAM_MSI_X_STARTV	GENMASK_ULL(31, 0)
> +
>   /* Next AFU Register Bitfield */
>   #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
>   
> @@ -272,11 +276,14 @@ struct dfl_feature_irq_ctx {
>    * @ops: ops of this sub feature.
>    * @ddev: ptr to the dfl device of this sub feature.
>    * @priv: priv data of this feature.
> + * @param_size: size of dfh parameters
> + * @params: point to memory copy of dfh parameters
>    */
>   struct dfl_feature {
>   	struct platform_device *dev;
>   	u16 id;
>   	u8 revision;
> +	u8 dfh_version;

Needs a description in the comments above.

I am concerned generally about backward compatibility and oot drivers 
that are dfh v0.

Adding an element in the middle will break things.

These structures could be more explicit about what is common, and what 
is v0 and v1 specific.

Tom

>   	int resource_index;
>   	void __iomem *ioaddr;
>   	struct dfl_feature_irq_ctx *irq_ctx;
> @@ -284,6 +291,8 @@ struct dfl_feature {
>   	const struct dfl_feature_ops *ops;
>   	struct dfl_device *ddev;
>   	void *priv;
> +	unsigned int param_size;
> +	void *params;
>   };
>   
>   #define FEATURE_DEV_ID_UNUSED	(-1)
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 431636a0dc78..3138ea42d02e 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -39,9 +39,12 @@ struct dfl_device {
>   	u16 type;
>   	u16 feature_id;
>   	u8 revision;
> +	u8 dfh_version;
>   	struct resource mmio_res;
>   	int *irqs;
>   	unsigned int num_irqs;
> +	unsigned int param_size;
> +	void *params;
>   	struct dfl_fpga_cdev *cdev;
>   	const struct dfl_device_id *id_entry;
>   };
> @@ -84,4 +87,7 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>   	module_driver(__dfl_driver, dfl_driver_register, \
>   		      dfl_driver_unregister)
>   
> +u64 *dfh_find_param(struct dfl_device *dfl_dev, int param);
> +
> +u64 *dfh_get_u64_param_vals(struct dfl_device *dfl_dev, int param_id, u64 *pval, int nvals);
>   #endif /* __LINUX_DFL_H */

